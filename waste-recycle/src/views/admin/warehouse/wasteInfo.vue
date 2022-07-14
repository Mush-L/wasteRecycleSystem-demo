<template>
<div>
  <el-card class="box-card">
    <el-descriptions class="margin-top" title="任务详情" :column="3" border>
      <template slot="extra">
        <el-button :type="isEditType" @click="wasteEdit" size="small">{{ isEditText }}</el-button>
      </template>
      <el-descriptions-item label="仓库编号">{{ info.waId }}</el-descriptions-item>
      <el-descriptions-item label="名称">{{ info.wname }}</el-descriptions-item>
      <el-descriptions-item label="分类">{{ info.wtype2 }}</el-descriptions-item>
      <el-descriptions-item label="详情">{{ info.wtype3 }}</el-descriptions-item>
      <el-descriptions-item label="重量">{{ info.ww }} kg</el-descriptions-item>
      <el-descriptions-item label="体积">{{ info.wv }} m³</el-descriptions-item>
      <el-descriptions-item label="任务编号">{{ info.wid }}</el-descriptions-item>
      <el-descriptions-item label="入库时间">{{ info.createTime }}</el-descriptions-item>
      <el-descriptions-item label="入库管理员">{{ info.inAdmin }}</el-descriptions-item>
      <el-descriptions-item label="备注">{{ info.wdesc }}</el-descriptions-item>
    </el-descriptions>
  </el-card>
  
  <el-card v-show="isEdit" class="box-card mt-20">
    <el-form ref="form" :model="form" label-width="80px">
      <el-form-item label="出库去向">
        <el-input v-model="form.wdesc" placeholder="请输入出库去向" />
      </el-form-item>
      <div class="mid-line">
        <el-button type="primary" @click="onSubmit" size="small">出库</el-button>
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
      if(this.isEditText === "出库"){
        this.isEditType = "danger";
        this.isEditText = "取消";
      }else{
        this.form = {},
        this.isEditType = "success";
        this.isEditText = "出库";
      }
    },
    onSubmit() {
      this.form.wid = this.info.wid;
      this.ttotype1(this.type);
      this.request.post("/waste", this.form).then((res) => {
        if (res) {
          this.$message.success("提交成功");
          this.$router.push({ name: "adminWarehouseList" });
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
      isEditText: "出库",
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
