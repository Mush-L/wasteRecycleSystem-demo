// 导入 Vue 和 路由
import Vue from "vue";
import VueRouter from "vue-router";

// 导入管理员和用户路由
import adminRoute from "./admin";
import adminInfo from "./admininfo";
import userRoute from "./user";

Vue.use(VueRouter);

const routes = [
  {
    path: "/",
    redirect: "/login",
    component: () => import("../views/login/index.vue"),
    children:[
      {
        path: "/login",
        component: () => import("../views/login/login.vue"),
        name: "login",
        meta: { title: "登录-废品回收管理系统" },
      },
      {
        path: "/register",
        component: () => import("../views/login/register.vue"),
        name: "register",
        meta: { title: "注册" },
      },
    ]
  },
  adminRoute,
  userRoute,
  adminInfo,
];

const router = new VueRouter({
  mode: "history",
  base: process.env.BASE_URL,
  routes,
});

export default router;

// 路由导航卫士
router.beforeEach((to, from, next) => {
  // 验证是否登录，做检查
  if(to.name!=="login" && to.name!=="register"){
    if(!localStorage.getItem("user")){
      next({ name: 'login' });
    }
  }

  // 根据路由设置标题
  if (to.meta.menu != null) {
    window.document.title = to.meta.menu;
  } else {
    window.document.title = to.meta.title;
  }
  next();
});
