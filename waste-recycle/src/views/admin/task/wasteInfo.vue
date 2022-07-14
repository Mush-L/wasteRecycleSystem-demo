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
      <div class="mid-line">
        <el-button type="primary" @click="onSubmit" size="small">更新</el-button>
        <el-button type="danger" @click="wasteEdit" size="small">取消</el-button>
      </div>
    </el-form>
  </el-card>
</div>
</template>

<script>
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
      this.form.wid = this.info.wid;
      this.ttotype1(this.type);
      this.request.post("/waste", this.form).then((res) => {
        if (res) {
          this.$message.success("提交成功");
          this.$router.push({ name: "adminWasteList" });
        } else {
          this.$message.error("提交失败");
        }
      });
    },

    handleChange(value){
      console.log(value);
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
      wasteOptions: wasteOption,
      type: "",
    };
  },
};
</script>

<style scoped>
</style>
