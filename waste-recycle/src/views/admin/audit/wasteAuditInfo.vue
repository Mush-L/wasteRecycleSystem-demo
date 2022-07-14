<template>
  <el-card>
    <el-descriptions class="margin-top" title="旧数据" :column="3" border>
      <el-descriptions-item label="物品ID">{{ info.wid }}</el-descriptions-item>
      <el-descriptions-item label="名称">{{ info.wname }}</el-descriptions-item>
      <el-descriptions-item label="归属用户ID">{{ form.uid }}</el-descriptions-item>
      <el-descriptions-item label="种类">{{ info.wtype1 }}</el-descriptions-item>
      <el-descriptions-item label="分类">{{ info.wtype2 }}</el-descriptions-item>
      <el-descriptions-item label="详细">{{ info.wtype3 }}</el-descriptions-item>
      <el-descriptions-item label="重量 (kg)">{{ info.ww }}</el-descriptions-item>
      <el-descriptions-item label="体积 (m³)">{{ info.wv }}</el-descriptions-item>
      <el-descriptions-item>&#12288;</el-descriptions-item>
      <el-descriptions-item label="物品描述">{{ info.wdesc }}</el-descriptions-item>
    </el-descriptions>
    <el-descriptions class="margin-top mt--1" :column="3" border>
      <el-descriptions-item label="预约日期">{{ info.tdata }}</el-descriptions-item>
      <el-descriptions-item label="地区">{{ info.taddress1 }}</el-descriptions-item>
      <el-descriptions-item label="地址">{{ info.taddress2 }}</el-descriptions-item>
      <el-descriptions-item label="任务描述">{{ info.tdesc }}</el-descriptions-item>
    </el-descriptions>
    <el-descriptions class="margin-top mt--1" :column="1" border>
      <el-descriptions-item label="修改原因">{{ form.auReason }}</el-descriptions-item>
    </el-descriptions>
    <div class="mid-line"></div>
    <el-descriptions class="margin-top" title="新数据" :column="3" border>
      <el-descriptions-item label="名称">{{ form.wname }}</el-descriptions-item>
      <el-descriptions-item label="种类">{{ form.wtype1 }}</el-descriptions-item>
      <el-descriptions-item label="分类">{{ form.wtype2 }}</el-descriptions-item>
      <el-descriptions-item label="详细">{{ form.wtype3 }}</el-descriptions-item>
      <el-descriptions-item label="重量 (kg)">{{ form.ww }}</el-descriptions-item>
      <el-descriptions-item label="体积 (m³)">{{ form.wv }}</el-descriptions-item>
      <el-descriptions-item label="物品描述">{{ form.wdesc }}</el-descriptions-item>
    </el-descriptions>
    <el-descriptions class="margin-top mt--1" :column="3" border>
      <el-descriptions-item label="预约日期">{{ form.tdata }}</el-descriptions-item>
      <el-descriptions-item label="地区">{{ form.taddress1 }}</el-descriptions-item>
      <el-descriptions-item label="地址">{{ form.taddress2 }}</el-descriptions-item>
      <el-descriptions-item label="任务描述">{{ form.tdesc }}</el-descriptions-item>
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
    if(this.form.wid){
      this.request.get("/waste/" + this.form.wid).then((res) => {
        if(res.code === "200"){
          this.info = res.data;
        }
      });
    }
  },
  methods:{
    onSubmit(){
      this.replace();
      this.request.post("/waste/", this.formtob).then((res) => {
        if(res.code === "200"){
          this.request.post("/auwaste/", this.form).then((res)=>{
            if(res.code === "200"){
              this.$router.push({name: "adminAuditWaste"});
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
      this.request.post("/auwaste", this.form).then((res)=>{
        if(res.code === "200"){
          this.$router.push({name: "adminAuditWaste"});
          this.$message.success("处理完成，已拒绝");
        }
      });
    },
    replace(){
      this.formtob.wid = this.form.wid;
      this.formtob.uid = this.form.uid;
      this.formtob.wname = this.form.wname;
      this.formtob.wtype1 = this.form.wtype1;
      this.formtob.wtype2 = this.form.wtype2;
      this.formtob.wtype3 = this.form.wtype3;
      this.formtob.ww = this.form.ww;
      this.formtob.wv = this.form.wv;
      this.formtob.wdesc = this.form.wdesc;
      this.formtob.tdate = this.form.tdate;
      this.formtob.taddress1 = this.form.taddress1;
      this.formtob.taddress2 = this.form.taddress2;
      this.formtob.tphoto = this.form.tphoto;
      this.formtob.tdesc = this.form.tdesc;
      this.formtob.tstate = "发布中";

      this.form.aaccount = this.user.userAccount;
      this.form.auResult = "已通过";
      this.form.auState = "已完成";
    },
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
