<template>
  <!-- 根据路由渲染菜单 -->
  <el-menu
    active-text-color="#42b983"
    style="height: 100%; overflow-x:hidden"
    router>
    <template v-for="route in routes" class="navMid">
      <!-- 判断是否存在子路由 -->
      <!-- 没有子路由 -->
      <el-menu-item
        v-if="!route.children"
        :key="route.path"
        :index="route.path"
      >
        <i :class="route.meta.icon"></i>
        <span slot="title">{{ route.meta.menu }}</span>
      </el-menu-item>
      <!-- 存在子路由 -->
      <el-submenu v-else :key="route.path" :index="route.path">
        <template slot="title">
          <i :class="route.meta.icon"></i>
          <span slot="title">{{ route.meta.menu }}</span>
        </template>
        <el-menu-item
          v-for="subRoute in route.children"
          :key="subRoute.path"
          :index="subRoute.path"
        >
          <span slot="title">{{ subRoute.meta.menu }}</span>
        </el-menu-item>
      </el-submenu>
    </template>
  </el-menu>
</template>

<script>

export default {
  computed: {
    routes() {
      const routes = this.$router.options.routes[1].children;
      // console.log(routes);
      return routes;
    },
  },
};
</script>

<style scoped>
.navMid {
  margin: 0 auto;
  text-align: center;
}
</style>
