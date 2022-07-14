<template>
  <el-container id="WRS">
    <el-header>
      <!-- 头部 -->
      <userhead></userhead>
    </el-header>
    <el-main>
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
</template>

<script>
import userhead from "../../components/userhead.vue";

export default {
  name: "App",
  components: { userhead },
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
  left: 5%;
  width: 90%;
  height: 100%;
}
.box-card {
  margin-left: 20%;
  width: 60%;
}
@media screen and (max-width: 1000px) {
  .box-card {
    margin-left: 5%;
    width: 90%;
  }
}
.box-card-list {
  margin-left: 15%;
  width: 70%;
}
@media screen and (max-width: 1000px) {
  .box-card-list {
    margin-left: 0;
    width: 100%;
  }
}
.mid-line {
  text-align: center;
}
.mt-20{
  margin-top: 20px;
}
.mt-10{
  margin-top: 10px;
}
.mt--1{
  margin-top: -1px;
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
