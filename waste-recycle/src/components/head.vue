<template>
  <el-row>
    <!-- 面包屑 -->
    <el-col :span="20">
      <el-breadcrumb separator="/">
        <el-breadcrumb-item
          v-for="item in breadcrumbList"
          :to="{ path: item.path }"
          :key="item.path">
          {{ item.meta.menu }}
        </el-breadcrumb-item>
      </el-breadcrumb>
    </el-col>
    <!-- 右侧下拉 -->
    <el-col :span="4">
      <el-header style="text-align: right; font-size: 12px">
        <el-dropdown>
          <span>{{ user.userName }}</span>
          <i class="el-icon-arrow-down" style="margin-right: 15px"></i>
          <el-dropdown-menu slot="dropdown">
            <el-dropdown-item @click.native="adminExit">我的信息</el-dropdown-item>
            <el-dropdown-item @click.native="loginout">退出登录</el-dropdown-item>
          </el-dropdown-menu>
        </el-dropdown>
      </el-header>
    </el-col>
  </el-row>
</template>

<script>
export default {
  methods: {
    adminExit() {
      this.$router.push({ name: "adminEdit" });
    },
    loginout() {
      localStorage.removeItem("user");
      this.$router.push({ name: "login" });
      this.$message.success("退出成功");
    },
  },
  computed: {
    breadcrumbList() {
      return this.$route.matched;
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
