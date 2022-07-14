<template>
  <div class="wrapper">
    <div class="login-box">
      <div class="login-text">
        <b>注 册</b>
      </div>
      <el-form :model="user" :rules="rules" ref="userForm">
        <el-form-item prop="username">
          <el-input
            class="form-input"
            prefix-icon="el-icon-user"
            placeholder="请输入账号"
            v-model="user.username"
          ></el-input>
        </el-form-item>
        <el-form-item prop="password">
          <el-input
            class="form-input"
            prefix-icon="el-icon-lock"
            placeholder="请输入密码"
            show-password
            v-model="user.password"
          ></el-input>
        </el-form-item>
        <el-form-item prop="confirmPassword">
          <el-input
            class="form-input"
            prefix-icon="el-icon-lock"
            placeholder="请确认密码"
            show-password
            v-model="user.confirmPassword"
          ></el-input>
        </el-form-item>
        <el-form-item>
          <el-button @click="changeToLogin">返回</el-button>
          <el-button icon="el-icon-switch-button" @click="changeToLogin" circle></el-button>
          <el-button type="primary" @click="register">注册</el-button>
        </el-form-item>
      </el-form>
    </div>
  </div>
</template>

<script>
export default {
  methods: {
    changeToLogin() {
      this.$router.push({ name: "login" });
    },
    reset() {
      this.user = {};
    },
    register() {
      this.$refs["userForm"].validate((valid) => {
        if (valid) {
          // 表单校验合法
          if (this.user.password !== this.user.confirmPassword) {
            this.$message.error("两次输入的密码不一致");
            return false;
          }
          this.request
            .post("/user/register", {
              userAccount: this.user.username,
              userPassword: this.user.password,
              userName: this.user.username,
            })
            .then((res) => {
              if (res.code === "200") {
                this.changeToLogin();
                this.$message.success("注册成功");
              } else {
                this.$message.error(res.msg);
              }
            });
        }
      });
    },
  },
  data() {
    return {
      user: {},
      rules: {
        username: [
          { required: true, message: "请输入用户名", trigger: "blur" },
          { min: 3, max: 10, message: "长度在 3 到 10 个字符", trigger: "blur" },
        ],
        password: [
          { required: true, message: "请输入密码", trigger: "blur" },
          {
            min: 6,
            max: 20,
            message: "长度在 6 到 20 个字符",
            trigger: "blur",
          },
        ],
        confirmPassword: [
          { required: true, message: "请输入密码", trigger: "blur" },
          {
            min: 6,
            max: 20,
            message: "长度在 1 到 20 个字符",
            trigger: "blur",
          },
        ],
      },
    };
  },
};
</script>

<style scoped>
.wrapper {
  position: absolute;
  height: 100vh;
  top: 0;
  bottom: 0;
  left: 0;
  right: 0;
  background-color: #00dbde;
  background-image: linear-gradient(
    135deg,
    #8aff85 0%,
    #4248ab 33%,
    #07818a 66%,
    #00dbde 100%
  );
  overflow: hidden;
}
.login-box {
  margin: 160px auto;
  width: 450px;
  height: 350px;
  padding: 10px;
  border: 1px solid white;
  font-family: Avenir, Helvetica, Arial, sans-serif;
  text-align: center;
}
.login-text {
  margin: 15px 0;
  font-size: 42px;
  color: white;
  text-align: center;
}
.form-input {
  margin: 5px 0;
  width: 80%;
}
</style>
