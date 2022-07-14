export default {
  // 管理员访问路由，后台管理
  path: "/admin",
  redirect: "/admin/index",
  component: () => import("../views/admin/index.vue"),
  meta: { menu: "系统" },
  children: [
    {
      path: "/admin/index",
      component: () => import("../views/admin/wrsystem.vue"),
      name: "adminIndex",
      meta: {
        menu: "系统首页",
        icon: "el-icon-pie-chart",
      },
    },
    {
      path: "/admin/user",
      name: "adminUser",
      redirect: "/admin/user_list",
      component: () => import("../views/admin/user/index.vue"),
      meta: {
        menu: "用户管理",
        icon: "el-icon-user",
      },
      children: [
        {
          path: "/admin/user_list",
          component: () => import("../views/admin/user/userList.vue"),
          name: "adminUserList",
          meta: {
            menu: "用户列表",
          },
        },
        {
          path: "/admin/user_add",
          component: () => import("../views/admin/user/userAdd.vue"),
          name: "adminUserAdd",
          meta: {
            menu: "新增用户",
          },
        },
      ],
    },
    {
      path: "/admin/task",
      name: "adminTask",
      redirect: "/admin/task_list",
      component: () => import("../views/admin/task/index.vue"),
      meta: {
        menu: "任务管理",
        icon: "el-icon-document-copy",
      },
      children: [
        {
          path: "/admin/task_list",
          component: () => import("../views/admin/task/taskList.vue"),
          name: "adminTaskList",
          meta: {
            menu: "任务列表",
          },
        },
        {
          path: "/admin/waste_list",
          component: () => import("../views/admin/task/wasteList.vue"),
          name: "adminWasteList",
          meta: {
            menu: "物品列表",
          },
        },
        {
          path: "/admin/task_add",
          component: () => import("../views/admin/task/taskAdd.vue"),
          name: "adminTaskAdd",
          meta: {
            menu: "新增任务",
          },
        },
      ],
    },
    {
      path: "/admin/audit",
      name: "adminAudit",
      redirect: "/admin/audit/user",
      component: () => import("../views/admin/audit/index.vue"),
      meta: {
        menu: "信息审核",
        icon: "el-icon-edit",
      },
      children: [
        {
          path: "/admin/audit/user",
          component: () => import("../views/admin/audit/userAudit.vue"),
          name: "adminAuditUser",
          meta: {
            menu: "用户审核",
          },
        },
        {
          path: "/admin/audit/waste",
          component: () => import("../views/admin/audit/wasteAudit.vue"),
          name: "adminAuditWaste",
          meta: {
            menu: "物品审核",
          },
        },
      ],
    },
    {
      path: "/admin/warehouse",
      name: "adminWarehouse",
      redirect: "/admin/warehouse/list",
      component: () => import("../views/admin/warehouse/index.vue"),
      meta: {
        menu: "仓库管理",
        icon: "el-icon-house",
      },
      children: [
        {
          path: "/admin/warehouse/list",
          component: () => import("../views/admin/warehouse/warehouseList.vue"),
          name: "adminWarehouseList",
          meta: {
            menu: "仓库列表",
          },
        },
        {
          path: "/admin/warehouse/inout",
          component: () => import("../views/admin/warehouse/warehouseInout.vue"),
          name: "adminWarehouseInout",
          meta: {
            menu: "物品入库",
          },
        },
      ],
    },
    {
      path: "/admin/edit",
      redirect: "/admin/edit/info",
      component: () => import("../views/admin/edit/index.vue"),
      name: "adminEdit",
      meta: {
        menu: "信息更新",
        icon: "el-icon-setting",
      },
      children: [
        {
          path: "/admin/edit/info",
          component: () => import("../views/admin/edit/info.vue"),
          name: "adminEditInfo",
          meta: {
            menu: "我的信息",
          },
        },
        {
          path: "/admin/edit/file",
          component: () => import("../views/admin/edit/file.vue"),
          name: "adminEditFile",
          meta: {
            menu: "文件管理",
          },
        },
      ],
    },
  ],
};
