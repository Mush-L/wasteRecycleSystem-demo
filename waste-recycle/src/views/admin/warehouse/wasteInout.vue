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
      <el-descriptions-item label="预约日期">{{ info.tdate }}</el-descriptions-item>
      <el-descriptions-item label="地区">{{ info.taddress1 }}</el-descriptions-item>
      <el-descriptions-item label="地址">{{ info.taddress2 }}</el-descriptions-item>
      <el-descriptions-item label="备注">{{ info.tdesc }}</el-descriptions-item>
    </el-descriptions>
  </el-card>
  
  <el-card v-show="isEdit" class="box-card mt-20">
    <div slot="header">
      <span>状态修改（点击完成入库）</span>
    </div>
    <el-form ref="form" :model="form" label-width="80px">
      <el-row>
        <el-col :span="12">
          <el-form-item label="任务状态">
            <el-select v-model="newTstate" placeholder="更改任务状态">
              <el-option label="发布中" value="发布中"></el-option>
              <el-option label="已接取" value="已接取"></el-option>
              <el-option label="已完成" value="已完成"></el-option>
            </el-select>
          </el-form-item>
        </el-col>
        <el-col :span="12">
          <el-form-item label="管理员:">
            {{user.userAccount}}
          </el-form-item>
        </el-col>
      </el-row>
      <div class="mid-line mt-20">
      <el-button type="primary" @click="onSubmit" size="small">更新</el-button>
      <el-button type="danger" @click="wasteEdit" size="small">取消</el-button>
    </div>
    </el-form>
  </el-card>
</div>
</template>

<script>
export default {
  created() {
    this.info = this.$route.params.info;
    this.newTstate = this.$route.params.info.tstate;
  },
  methods: {
    wasteEdit(){
      this.isEdit = !this.isEdit;
      if(this.isEditText === "编辑"){
        this.isEditType = "danger";
        this.isEditText = "取消";
      }else{
        this.newTstate = this.info.tstate;
        this.isEditType = "success";
        this.isEditText = "编辑";
      }
    },
    onSubmit() {
      if(this.newTstate === "已完成"){
        this.taskTowaste();
      }
      this.request.post("/waste", this.form).then((res) => {
        if (res) {
          this.$message.success("提交成功");
          this.$router.push({ name: "adminTaskList" });
        } else {
          this.$message.error("提交失败");
        }
      });
    },
    taskTowaste(){
      this.form.wid = this.info.wid;
      this.form.wname = this.info.wname;
      this.form.type1 = this.info.type1;
      this.form.type2 = this.info.type2;
      this.form.type3 = this.info.type3;
      this.form.ww = this.info.ww;
      this.form.wv = this.info.wv;
      this.form.wphoto = this.info.tphoto;
      this.form.wdesc = this.info.wdesc;
      this.form.inAdmin = this.user.userAccount;
    }
  },
  data() {
    return {
      isEdit: false,
      isEditType: "success",
      isEditText: "编辑",
      user: localStorage.getItem("user") ? JSON.parse(localStorage.getItem("user")) : {},
      info: {},
      form:{},
      newTstate: "",
    };
  },
};
</script>

<style scoped>
</style>
