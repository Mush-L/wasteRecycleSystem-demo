export default {
  // 用户访问路由，还没写
  path: "/user",
  redirect: "/index",
  component: () => import("../views/user/index.vue"),
  meta: { menu: "系统" },
  children: [
    {
      path: "/index",
      name: "userIndex",
      component: () => import("../views/user/wrsystem.vue"),
      meta: { menu: "系统首页" },
    },
    {
      path: "/task",
      name: "userTask",
      redirect: "/task/list",
      component: () => import("../views/user/tasklist/index.vue"),
      meta: { menu: "任务广场" },
      children: [
        {
          path: "/task/list",
          name: "userTaskList",
          component: () => import("../views/user/tasklist/taskList.vue"),
          meta: { menu: "任务列表" },
        },
        {
          path: "/task/info",
          name: "userTaskInfo",
          component: () => import("../views/user/tasklist/taskInfo.vue"),
          meta: { menu: "任务详情" },
        },
      ]
    },
    {
      path: "/my_task",
      name: "userMyTask",
      redirect: "/my_task/list",
      component: () => import("../views/user/mytask/index.vue"),
      meta: { menu: "我的任务" },
      children: [
        {
          path: "/my_task/list",
          name: "userMyTaskList",
          component: () => import("../views/user/mytask/taskList.vue"),
          meta: { menu: "任务列表" },
        },
        {
          path: "/my_task/add",
          name: "userMyTaskAdd",
          component: () => import("../views/user/mytask/taskAdd.vue"),
          meta: { menu: "发布任务" },
        },
        {
          path: "/my_task/info",
          name: "userMyTaskInfo",
          component: () => import("../views/user/mytask/taskInfo.vue"),
          meta: { menu: "任务详情" },
        },
      ]
    },
    {
      path: "/audit",
      name: "userAudit",
      redirect: "/audit/user_list",
      component: () => import("../views/user/audit/index.vue"),
      meta: { menu: "申请记录" },
      children: [
        {
          path: "/audit/user_list",
          name: "userAuditUser",
          component: () => import("../views/user/audit/auditUserList.vue"),
          meta: { menu: "个人信息更改" },
        },
        {
          path: "/audit/waste_list",
          name: "userAuditWaste",
          component: () => import("../views/user/audit/auditWasteList.vue"),
          meta: { menu: "任务信息更改" },
        },
      ]
    },
    {
      path: "/userInfo",
      name: "userInfo",
      redirect: "/userInfo/show",
      component: () => import("../views/user/userinfo/index.vue"),
      meta: { menu: "个人信息" },
      children: [
        {
          path: "/userInfo/show",
          name: "userInfoShow",
          component: () => import("../views/user/userinfo/show.vue"),
          meta: { menu: "我的信息" },
        },
        {
          path: "/userInfo/update",
          name: "userInfoUpdate",
          component: () => import("../views/user/userinfo/update.vue"),
          meta: { menu: "信息更新" },
        },
      ]
    },
    {
      path: "/about",
      name: "aboutus",
      component: () => import("../views/user/about.vue"),
      meta: { menu: "关于我们" },
    },
  ],
};
