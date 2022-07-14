<template>
  <el-card class="box-card">
    <div slot="header">
      <span>新增用户</span>
    </div>
    <el-form ref="form" :model="form" label-width="80px">
      <el-row>
        <el-col :span="12">
          <el-form-item label="账号">
            <el-input v-model="form.userAccount"></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="12">
          <el-form-item label="权限">
            <el-select v-model="form.userSex" placeholder="请选择账号权限">
              <el-option label="S 超级管理" value="S"></el-option>
              <el-option label="A 运输管理" value="A"></el-option>
              <el-option label="M 仓库管理" value="M"></el-option>
              <el-option label="B 普通用户" value="B"></el-option>
            </el-select>
          </el-form-item>
        </el-col>
      </el-row>
      <el-row>
        <el-col :span="12">
          <el-form-item label="姓名">
            <el-input v-model="form.userName"></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="12">
          <el-form-item label="电话">
            <el-input v-model="form.userPhone"></el-input>
          </el-form-item>
        </el-col>
      </el-row>
      <el-row>
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
            <el-input v-model="form.userAge"></el-input>
          </el-form-item>
        </el-col>
      </el-row>
      <el-form-item label="其他">
        <el-input type="textarea" v-model="desc"></el-input>
      </el-form-item>
      <div class="mid-line">
        <el-button @click="onSubmit" type="primary">保存</el-button>
        <el-button @click="handleChange">取消</el-button>
      </div>
    </el-form>
  </el-card>
</template>

<script>
export default {
  data() {
    return {
      form: {
        userName: "",
        userAccount: "",
        // userPassword: "",
        userSex: "",
        userAge: "",
        userPhone: "",
      },
      desc: "",
    };
  },
  methods: {
    onSubmit() {
      this.request.post("/user", this.form).then((res) => {
        if (res.data) {
          this.$message.success("保存成功");
          this.$router.push({ name: "adminUser" });
        } else {
          this.$message.error("保存失败");
        }
      });
    },
    handleChange(value) {
      this.$router.push({ name: "adminUser" });
    },
  },
};
</script>

<style scoped>
.mid-line {
  text-align: center;
}
</style>
