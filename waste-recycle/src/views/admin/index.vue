<template>
  <el-container id="WRS">
    <!-- 左侧导航栏单独布局 -->
    <el-aside class="nav" width="null">
      <navbar></navbar>
    </el-aside>
    <el-container>
      <el-main>
        <!-- 头部 -->
        <headbar></headbar>
        <!-- 对路由视窗写入 transition 实现进入/离开动画 -->
        <transition name="component-fade" mode="out-in">
          <router-view></router-view>
        </transition>
      </el-main>
      <!-- 页尾 -->
      <el-footer>
        <footer class="footer">
          <p>© 2022 Waste Recycle System</p>
        </footer>
      </el-footer>
    </el-container>
  </el-container>
</template>

<script>
import navbar from "../../components/navbar.vue";
import headbar from "../../components/head.vue";

export default {
  name: "App",
  components: { navbar, headbar },
};
</script>

<style>
/* 整体页面布局,部分清除 */
#WRS {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
}
/* 侧边导航栏宽度 */
.nav {
  width: 15%;
  box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.1);
}
/* card盒子宽度 */
.box-card {
  margin-left: 20%;
  width: 60%;
}
@media screen and (max-width: 1000px) {
  .box-card {
    margin-left: 0;
    width: 100%;
  }
}
.box-card-list {
  margin-left: 5%;
  width: 90%;
}
@media screen and (max-width: 1000px) {
  .box-card-list {
    margin-left: 0;
    width: 100%;
  }
}
/* 上边距 20px */
.mt-20{
  margin-top: 20px;
}
.mt--1{
  margin-top: -1px;
}
/* 左边距 10px */
.ml-10{
  margin-left: 10px;
}
/* 居中 */
.mid-line{
  text-align: center;
}
/* 页脚格式 */
.footer {
  font-size: 10px;
  text-align: center;
  clear: both;
}
/* 淡入淡出动画 */
.component-fade-enter-active,
.component-fade-leave-active {
  transition: opacity 0.3s ease;
}
.component-fade-enter, .component-fade-leave-to
/* .component-fade-leave-active for below version 2.1.8 */ {
  opacity: 0;
}
</style>
