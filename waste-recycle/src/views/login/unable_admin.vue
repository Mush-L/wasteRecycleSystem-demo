<template>
  <div class="wrapper">
    <div class="login-box">
      <div class="login-text">
        <b>管 理 员</b>
      </div>
      <el-form :model="user" :rules="rules" ref="userForm">
        <el-form-item prop="username">
          <el-input class="form-input" v-model="user.username"></el-input>
        </el-form-item>
        <el-form-item prop="password">
          <el-input
            class="form-input"
            show-password
            v-model="user.password"
          ></el-input>
        </el-form-item>
        <el-form-item>
          <el-button disabled>注册</el-button>
          <el-button
            icon="el-icon-turn-off"
            @click="changeToUser"
            circle
          ></el-button>
          <el-button type="primary" autocomplete="off" @click="login"
            >登录</el-button
          >
        </el-form-item>
      </el-form>
    </div>
  </div>
</template>

<script>
export default {
  // name: "Login",
  data() {
    return {
      user: {},
      rules: {
        username: [
          { required: true, message: "请输入用户名", trigger: "blur" },
          { min: 3, max: 10, message: "长度在 3 到 5 个字符", trigger: "blur" },
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
      },
    };
  },
  methods: {
    login() {
      this.$refs["userForm"].validate((valid) => {
        if (valid) {
          // 表单校验合法
          this.request.post("/user/login", this.user).then((res) => {
            if (!res) {
              this.$message.error("用户名或密码错误");
            } else {
              this.$router.push("/");
            }
          });
        } else {
          return false;
        }
      });
    },
    changeToUser() {
      this.$router.push({ name: "login" });
    },
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
  background-color: #ff0066;
  background-image: linear-gradient(
    135deg,
    #ff0066 0%,
    #283443 33%,
    #a03333 66%,
    #283443 100%
  );
  overflow: hidden;
}
.login-box {
  margin: 160px auto;
  width: 450px;
  height: 300px;
  padding: 20px;
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
  margin: 10px 0;
  width: 80%;
}
</style>
