<template>
  <div class="wrapper">
    <div class="login-box" v-show="isShow1">
      <div class="login-text">
        <b>管 理 员</b>
      </div>
      <el-form :model="admin" :rules="rules" ref="adminForm">
        <el-form-item prop="username">
          <el-input class="form-input" v-model="admin.username"></el-input>
        </el-form-item>
        <el-form-item prop="password">
          <el-input
            class="form-input"
            show-password
            v-model="admin.password"
          ></el-input>
        </el-form-item>
        <el-form-item>
          <el-button disabled>注册</el-button>
          <el-button
            icon="el-icon-turn-off"
            @click="changeToLogin"
            circle
          ></el-button>
          <el-button type="primary" @click="adminLogin">登录</el-button>
        </el-form-item>
      </el-form>
    </div>
    <div class="login-box" v-show="isShow2">
      <div class="login-text">
        <b>登 录</b>
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
          <el-button @click="changeToRegister">注册</el-button>
          <el-button
            icon="el-icon-open"
            @click="changeToLogin"
            circle
          ></el-button>
          <el-button type="primary" @click="userLogin">登录</el-button>
        </el-form-item>
      </el-form>
    </div>
  </div>
</template>

<script>
export default {
  created() {
    this.load();
  },
  methods: {
    load() {
      this.admin = { username: "mush", password: "mushuo" };
      this.user = { username: "qianyu", password: "qianyu" };
    },
    adminLogin() {
      this.$refs["userForm"].validate((valid) => {
        if (valid) {
          // 表单校验合法
          this.request
            .post("/user/login", {
              userAccount: this.admin.username,
              userPassword: this.admin.password,
            })
            .then((res) => {
              if (res.code === "200") {
                localStorage.setItem("user", JSON.stringify(res.data)); // 存储用户信息到浏览器
                if (res.data.userState === "S") {
                  this.$router.push({ name: "adminIndex" });
                } else if (res.data.userState === "B") {
                  this.$router.push({ name: "userIndex" });
                }
                this.$message.success("登录成功");
              } else {
                this.$message.error(res.msg);
              }
            });
        } else {
          return false;
        }
      });
    },
    userLogin() {
      this.$refs["userForm"].validate((valid) => {
        if (valid) {
          // 表单校验合法
          this.request
            .post("/user/login", {
              userAccount: this.user.username,
              userPassword: this.user.password,
            })
            .then((res) => {
              if (res.code === "200") {
                localStorage.setItem("user", JSON.stringify(res.data)); // 存储用户信息到浏览器
                if (res.data.userState === "S") {
                  this.$router.push({ name: "adminIndex" });
                } else if (res.data.userState === "B") {
                  this.$router.push({ name: "userIndex" });
                }
                this.$message.success("登录成功");
              } else {
                this.$message.error(res.msg);
              }
            });
        } else {
          return false;
        }
      });
    },
    changeToLogin() {
      this.load();
      this.isShow1 = !this.isShow1;
      this.isShow2 = !this.isShow2;
    },

    changeToRegister() {
      this.$router.push({ name: "register" });
    },
  },
  data() {
    return {
      isShow1: false,
      isShow2: true,
      user: {},
      admin: {},
      rules: {
        username: [
          { required: true, message: "请输入用户名", trigger: "blur" },
          {
            min: 3,
            max: 10,
            message: "长度在 3 到 10 个字符",
            trigger: "blur",
          },
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
    #00dbde 0%,
    #07818a 33%,
    #4248ab 66%,
    #8aff85 100%
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
