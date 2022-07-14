<template>
<div>
  <el-card class="box-card">
    <el-descriptions class="margin-top" title="任务详情" :column="3" border>
      <template slot="extra">
        <el-button :type="isEditType" @click="wasteEdit" size="small">{{ isEditText }}</el-button>
      </template>
      <el-descriptions-item label="物品ID">{{ info.wid }}</el-descriptions-item>
      <el-descriptions-item label="名称">{{ info.wname }}</el-descriptions-item>
      <el-descriptions-item label="分类">{{ info.wtype2 }}</el-descriptions-item>
      <el-descriptions-item label="详情">{{ info.wtype3 }}</el-descriptions-item>
      <el-descriptions-item label="重量">{{ info.ww }} kg</el-descriptions-item>
      <el-descriptions-item label="体积">{{ info.wv }} m³</el-descriptions-item>
      <el-descriptions-item label="备注">{{ info.wdesc }}</el-descriptions-item>
    </el-descriptions>
    <el-descriptions class="margin-top mt--1" :column="3" border>
      <el-descriptions-item label="预约日期">{{ info.tdate }}</el-descriptions-item>
      <el-descriptions-item label="地区">{{ info.taddress1 }}</el-descriptions-item>
      <el-descriptions-item label="地址">{{ info.taddress2 }}</el-descriptions-item>
      <el-descriptions-item label="备注">{{ info.tdesc }}</el-descriptions-item>
    </el-descriptions>
  </el-card>

  
  <el-card v-show="isEdit" class="box-card mt-20">
    <div slot="header">
      <span>更新信息（保留原数据则留空）</span>
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
          <el-form-item label="任务图片">
            <el-input v-model="form.tphoto" placeholder="暂不支持修改图片" :disabled="true"/>
          </el-form-item>
        </el-col>
      </el-row>
      <el-form-item label="任务备注">
        <el-input v-model="form.tdesc" placeholder="一言以蔽之" />
      </el-form-item>
      <el-form-item label="修改原因">
        <el-input type="textarea" v-model="form.auReason" />
      </el-form-item>
      <div class="mid-line">
        <el-button type="primary" @click="onSubmit" size="small">提交申请</el-button>
        <el-button type="danger" @click="wasteEdit" size="small">取消提交</el-button>
      </div>
    </el-form>
  </el-card>
</div>
</template>

<script>
import { regionDataPlus, CodeToText, TextToCode } from 'element-china-area-data'
import wasteOption from "../../../assets/js/waste-race";

export default {
  created() {
    this.info = this.$route.params.info;
  },
  methods: {
    wasteEdit(){
      this.isEdit = !this.isEdit;
      if(this.isEditText === "编辑"){
        this.isEditType = "danger";
        this.isEditText = "取消";
      }else{
        this.form = {},
        this.isEditType = "success";
        this.isEditText = "编辑";
      }
    },
    onSubmit() {
      this.ctoadd1(this.address);
      this.ttotype1(this.type);
      this.form.wid = this.info.wid;
      this.form.uid = this.user.userId;
      this.request.post("/auwaste", this.form).then((res) => {
        if (res) {
          this.$message.success("提交成功");
          this.$router.push({ name: "userAuditWaste" });
        } else {
          this.$message.error("提交失败");
        }
      });
    },

    handleChange(value){
      console.log(value);
    },
    // 转地区
    ctoadd1(value){
      var dz;
        if (value[1] != null && value[2] != null) {
          dz = CodeToText[value[0]] + '/' + CodeToText[value[1]] + '/' + CodeToText[value[2]];
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
  },
  data() {
    return {
      isEdit: false,
      isEditType: "success",
      isEditText: "编辑",
      info: {},
      form: {},
      addOptions: regionDataPlus,
      wasteOptions: wasteOption,
      user: localStorage.getItem("user") ? JSON.parse(localStorage.getItem("user")) : {},
      address: "",
      type: "",
    };
  },
};
</script>

<style scoped>
</style>
