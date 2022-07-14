<template>
<div>
  <el-card class="box-card">
    <el-descriptions class="margin-top" title="用户详情" :column="3" border>
      <template slot="extra">
        <el-button :type="isEditType" @click="infoEdit" size="small">{{ isEditText }}</el-button>
      </template>
      <el-descriptions-item label="管理员ID">{{ info.userId }}</el-descriptions-item>
      <el-descriptions-item label="账号">{{ info.userAccount }}</el-descriptions-item>
      <el-descriptions-item label="姓名">{{ info.userName }}</el-descriptions-item>
      <el-descriptions-item label="性别">{{ info.userSex }}</el-descriptions-item>
      <el-descriptions-item label="年龄">{{ info.userAge }}</el-descriptions-item>
      <el-descriptions-item label="手机号">{{ info.userPhone }}</el-descriptions-item>
    </el-descriptions>
  </el-card>

    <el-card v-show="isEdit" class="box-card mt-20">
    <div slot="header">
      <span>更新信息（保留原数据则留空）</span>
    </div>
    <el-form ref="form" :model="form" label-width="80px">
      <el-row>
        <el-col :span="12">
          <el-form-item label="姓名">
            <el-input v-model="form.userName" placeholder="请输入姓名" />
          </el-form-item>
        </el-col>
        <el-col :span="12">
          <el-form-item label="性别">
            <el-select v-model="form.userSex" placeholder="请选择性别">
              <el-option label="保密" value="保密"></el-option>
              <el-option label="男" value="男"></el-option>
              <el-option label="女" value="女"></el-option>
            </el-select>
          </el-form-item>
        </el-col>
        <el-col :span="12">
          <el-form-item label="年龄">
            <el-input v-model="form.userAge" placeholder="请输入年龄" />
          </el-form-item>
        </el-col>
        <el-col :span="12">
          <el-form-item label="手机号">
            <el-input v-model="form.userPhone" placeholder="请输入手机号" />
          </el-form-item>
        </el-col>
      </el-row>
      <div class="mid-line">
        <el-button type="primary" @click="onSubmit" size="small">更新</el-button>
        <el-button type="danger" @click="infoEdit" size="small">取消</el-button>
      </div>
    </el-form>
  </el-card>
</div>
  
</template>

<script>
export default {
  created() {
    this.search();
  },
  methods: {
    infoEdit(){
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
    onSubmit(){
      this.request.post("/user/" + this.user.userId).then((res) => {
        if (res.code === "200") {
          this.info = res.data;
        }
      });
    },
    search() {
      this.request.get("/user/" + this.user.userId).then((res) => {
        if (res.code === "200") {
          this.info = res.data;
        }
      });
    },
  },
  data() {
    return {
      isEdit: false,
      isEditType: "success",
      isEditText: "编辑",
      user: localStorage.getItem("user") ? JSON.parse(localStorage.getItem("user")) : {},
      info: {},
      form: {},
    };
  },
};
</script>

<style scoped></style>
