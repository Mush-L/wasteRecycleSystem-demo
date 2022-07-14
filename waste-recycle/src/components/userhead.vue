<template>
  <el-row>
    <el-col :span="4">
      <div>&#12288;</div>
    </el-col>
    <el-col :span="16">
      <el-menu class="el-menu-demo" mode="horizontal" router>
        <el-menu-item key="/index" index="/index">首页</el-menu-item>
        <el-menu-item key="/task" index="/task">任务广场</el-menu-item>
        <el-submenu index="/my_task">
          <template slot="title">我的任务</template>
          <el-menu-item key="/my_task/list" index="/my_task/list">
            我发布的任务
          </el-menu-item>
          <el-menu-item key="/my_task/add" index="/my_task/add">
            发布新任务
          </el-menu-item>
        </el-submenu><el-submenu index="/audit">
          <template slot="title">申请历史</template>
          <el-menu-item key="/audit/user_list" index="/audit/user_list">
            个人信息更改
          </el-menu-item>
          <el-menu-item key="/audit/waste_list" index="/audit/waste_list">
            任务信息更改
          </el-menu-item>
        </el-submenu>
        <el-menu-item key="/about" index="/about">关于我们</el-menu-item>
      </el-menu>
    </el-col>
    <!-- 右侧下拉 -->
    <el-col :span="4">
      <el-header style="text-align: right; font-size: 12px; margin-top: 20px">
        <el-dropdown>
          <span>{{ user.userName }}</span>
          <i class="el-icon-arrow-down" style="margin-right: 15px"></i>
          <el-dropdown-menu slot="dropdown">
            <el-dropdown-item @click.native="userExit"
              >我的信息</el-dropdown-item
            >
            <el-dropdown-item @click.native="loginout"
              >退出登录</el-dropdown-item
            >
          </el-dropdown-menu>
        </el-dropdown>
      </el-header>
    </el-col>
  </el-row>
</template>

<script>
export default {
  methods: {
    userExit() {
      this.$router.push({ name: "userInfo" });
    },
    loginout() {
      localStorage.removeItem("user");
      this.$router.push({ name: "login" });
      this.$message.success("退出成功");
    },
  },
  data() {
    return {
      user: localStorage.getItem("user") ? JSON.parse(localStorage.getItem("user")) : {},
    };
  },
};
</script>

<style scoped></style>
