<template>
  <el-card>
    <el-descriptions class="margin-top" title="旧数据" :column="3" border>
      <el-descriptions-item label="ID">{{ info.userId }}</el-descriptions-item>
      <el-descriptions-item label="账号">{{ info.userAccount }}</el-descriptions-item>
      <el-descriptions-item label="姓名">{{ info.userName }}</el-descriptions-item>
      <el-descriptions-item label="性别">{{ info.userSex }}</el-descriptions-item>
      <el-descriptions-item label="年龄">{{ info.userAge }}</el-descriptions-item>
      <el-descriptions-item label="手机号">{{ info.userPhone }}</el-descriptions-item>
      <el-descriptions-item label="修改原因">{{ form.ureason }}</el-descriptions-item>
    </el-descriptions>
    <div class="mid-line"></div>
    <el-descriptions class="margin-top" title="新数据" :column="2" border>
      <el-descriptions-item label="姓名">{{ form.uname }}</el-descriptions-item>
      <el-descriptions-item label="性别">{{ form.usex }}</el-descriptions-item>
      <el-descriptions-item label="年龄">{{ form.uage }}</el-descriptions-item>
      <el-descriptions-item label="手机号">{{ form.uphone }}</el-descriptions-item>
    </el-descriptions>
    <el-row class="mid-line">
      <el-button @click="onSubmit" type="primary">通过</el-button>
      <el-button @click="cancle" type="danger">拒绝</el-button>
    </el-row>
  </el-card>
</template>

<script>
export default {
  created(){
    this.form = this.$route.params.info;
    this.request.get("/user/" + this.form.uid).then((res) => {
      if(res.code === "200"){
        this.info = res.data;
      }
    });
  },
  methods:{
    onSubmit(){
      this.replace();
      this.request.post("/user/", this.formtob).then((res) => {
        if(res.code === "200"){
          this.request.post("/auuser/", this.form).then((res)=>{
            if(res.code === "200"){
              this.$router.push({name: "adminAuditUser"});
              this.$message.success("处理完成，已同意");
            }
          });
        }
      });
    },
    cancle(){
      this.form.aaccount = this.user.userAccount;
      this.form.auResult = "已拒绝";
      this.form.auState = "已完成";
      this.request.post("/auuser/", this.form).then((res)=>{
        if(res.code === "200"){
          this.$router.push({name: "adminAuditUser"});
          this.$message.success("处理完成，已拒绝");
        }
      });
    },
    replace(){
      this.formtob.userId = this.form.uid;
      this.formtob.userName = this.form.uname;
      this.formtob.userSex = this.form.usex;
      this.formtob.userAge = this.form.uage;
      this.formtob.userPhone = this.form.uphone;
      this.form.aaccount = this.user.userAccount;
      this.form.auResult = "已通过";
      this.form.auState = "已完成";
    }
  },
  data() {
    return {
      user: localStorage.getItem("user") ? JSON.parse(localStorage.getItem("user")) : {},
      info: {},
      form: {},
      formtob: {},
    };
  },
};
</script>

<style scoped>
.mid-line {
  margin-top: 20px;
  text-align: center;
}
</style>
