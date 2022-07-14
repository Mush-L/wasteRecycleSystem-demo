<template>
  <el-card class="box-card">
    <div slot="header">
      <span>新增任务</span>
    </div>
    <el-form ref="form" :model="form" label-width="80px">
      <el-form-item label="物品名称">
        <el-input v-model="form.wname" />
      </el-form-item>
      <el-row>
        <el-col :span="12">
          <el-form-item label="物品种类">
            <el-cascader placeholder="选择种类" v-model="type" :options="wasteOptions" @change="handleChange" style="width: 100%" />
          </el-form-item>
        </el-col>
        <el-col :span="12">
          <el-form-item label="详细">
            <el-input v-model="form.wtype3" placeholder="*选其他可填" />
          </el-form-item>
        </el-col>
        <el-col :span="12">
          <el-form-item label="物品重量">
            <el-input v-model="form.ww" placeholder="单位:kg" />
          </el-form-item>
        </el-col>
        <el-col :span="12">
          <el-form-item label="物品体积">
            <el-input v-model="form.wv" placeholder="单位:m³" />
          </el-form-item>
        </el-col>
      </el-row>
      <el-form-item label="物品备注">
        <el-input v-model="form.wdesc" placeholder="一言以蔽之" />
      </el-form-item>
      <el-row>
        <el-form-item label="任务地区">
          <el-col :span="8">
            <el-cascader size="large" :options="addOptions" v-model="address" @change="handleChange" style="width: 100%"/>
          </el-col>
          <el-col class="mid-line" :span="1">-</el-col>
          <el-col :span="15">
            <el-input v-model="form.taddress2" placeholder="详细地点" />
          </el-col>
        </el-form-item>
        <el-col :span="12">
          <el-form-item label="预约日期">
              <el-date-picker type="date" placeholder="选择日期" v-model="form.tdate" style="width: 100%" />
          </el-form-item>
        </el-col>
        <el-col :span="12">
          <el-form-item label="上传图片">
            <el-button>点击上传</el-button>
            <!-- <el-input placeholder="图片地址" /> -->
          </el-form-item>
        </el-col>
      </el-row>
      <el-form-item label="任务备注">
        <el-input type="textarea" v-model="form.tdesc" />
      </el-form-item>
      <div class="mid-line">
        <el-button type="primary" @click="onSubmit">立即创建</el-button>
        <el-button @click="cancle">取消</el-button>
      </div>
    </el-form>
  </el-card>
</template>

<script>
import { regionDataPlus, CodeToText, TextToCode } from 'element-china-area-data'
import wasteOption from "../../../assets/js/waste-race";

export default {
  methods: {
    onSubmit() {
      this.ctoadd1(this.address);
      this.ttotype1(this.type);
      this.form.uid = this.user.userId,
      this.form.auReason = "发布新任务";
      this.request.post("/auwaste", this.form).then((res) => {
        if (res.data) {
          this.$message.success("保存成功");
          this.$router.push({ name: "userMyTaskList" });
        } else {
          this.$message.error("保存失败");
        }
      });
    },
    cancle(){
      this.$router.push({ name: "userMyTaskList" });
    },
    handleChange(value) {
      console.log(value);
    },
    // 转地区
    ctoadd1(value){
        if (value[1] != null && value[2] != null) {
          var dz = CodeToText[value[0]] + '/' + CodeToText[value[1]] + '/' + CodeToText[value[2]];
          this.addressid = value[2];
        } else {
          if (value[1] != null) {
            dz = CodeToText[value[0]] + '/' + CodeToText[value[1]];
            this.addressid = value[1];
          } else {
            dz = CodeToText[value[0]];
            this.addressid = value[0];
          }
        }
        this.form.taddress1 = dz;
    },
    // 转种类
    ttotype1(value){
      if(value[2]!=="其他"){
        this.form.wtype3=value[2];
      }
      this.form.wtype1=value[0];
      this.form.wtype2=value[1];
    },
  },  data() {
    return {
      addOptions: regionDataPlus,
      wasteOptions: wasteOption,
      user: localStorage.getItem("user") ? JSON.parse(localStorage.getItem("user")) : {},
      address: "",
      type: "",
      form: {},
    };
  },
};
</script>

<style scoped>
.mid-line {
  text-align: center;
}
</style>
