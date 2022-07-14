export default {
  // 管理员访问路由，后台管理
  path: "/admin",
  component: () => import("../views/admin/index.vue"),
  meta: { menu: "系统" },
  children: [
    {
      path: "/admin/user",
      component: () => import("../views/admin/user/index.vue"),
      meta: { menu: "用户管理" },
      children: [
        {
          path: "/admin/user_info",
          component: () => import("../views/admin/user/userInfo.vue"),
          name: "adminUserInfo",
          meta: {
            menu: "用户详情",
          },
        },
      ],
    },
    {
      path: "/admin/task",
      meta: { menu: "任务管理" },
      component: () => import("../views/admin/task/index.vue"),
      children: [
        {
          path: "/admin/task_info",
          component: () => import("../views/admin/task/taskInfo.vue"),
          name: "adminTaskInfo",
          meta: {
            menu: "任务详情",
          },
        },
        {
          path: "/admin/waste_info",
          component: () => import("../views/admin/task/wasteInfo.vue"),
          name: "adminWasteInfo",
          meta: {
            menu: "物品详情",
          },
        },
      ],
    },
    {
      path: "/admin/audit",
      meta: { menu: "信息审核" },
      component: () => import("../views/admin/audit/index.vue"),
      children: [
        {
          path: "/admin/audit/user_info",
          component: () => import("../views/admin/audit/userAuditInfo.vue"),
          name: "adminAuditUserInfo",
          meta: {
            menu: "用户审核详情",
          },
        },
        {
          path: "/admin/audit/waste_info",
          component: () => import("../views/admin/audit/wasteAuditInfo.vue"),
          name: "adminAuditWasteInfo",
          meta: {
            menu: "物品审核详情",
          },
        },
        {
          path: "/admin/audit/task",
          component: () => import("../views/admin/audit/unable_taskAudit.vue"),
          name: "adminAuditTask",
          meta: {
            menu: "任务审核",
          },
        },
        {
          path: "/admin/audit/task_info",
          component: () => import("../views/admin/audit/unable_taskAuditInfo.vue"),
          name: "adminAuditTaskInfo",
          meta: {
            menu: "任务审核详情",
          },
        },
      ],
    },
    {
      path: "/admin/warehouse",
      meta: { menu: "仓库管理" },
      component: () => import("../views/admin/warehouse/index.vue"),
      children: [
        {
          path: "/admin/warehouse/waste_info",
          component: () => import("../views/admin/warehouse/wasteInfo.vue"),
          name: "adminWarehouseWasteInfo",
          meta: {
            menu: "仓库物品详情",
          },
        },
        {
          path: "/admin/warehouse/waste_inout",
          component: () => import("../views/admin/warehouse/wasteInout.vue"),
          name: "adminWarehouseWasteInout",
          meta: {
            menu: "物品入库",
          },
        },
      ],
    },
  ],
};
