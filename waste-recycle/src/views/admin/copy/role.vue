<template>
  <el-dialog title="菜单分配" :visible.sync="menuDialogVis" width="30%">
    <el-tree
      :props="props"
      :data="menuData"
      show-checkbox
      node-key="id"
      ref="tree"
      :default-expanded-keys="expends"
      :default-checked-keys="checks"
    >
      <span class="custom-tree-node" slot-scope="{ node, data }">
        <span><i :class="data.icon"></i> {{ data.name }}</span>
      </span>
    </el-tree>
    <div slot="footer" class="dialog-footer">
      <el-button @click="menuDialogVis = false">取 消</el-button>
      <el-button type="primary" @click="saveRoleMenu">确 定</el-button>
    </div>
  </el-dialog>
</template>

<script>
export default {
  saveRoleMenu() {
    this.request
      .post("/role/roleMenu/" + this.roleId, this.$refs.tree.getCheckedKeys())
      .then((res) => {
        if (res.code === "200") {
          this.$message.success("绑定成功");
          this.menuDialogVis = false;

          // 操作管理员角色后需要重新登录
          if (this.roleFlag === "ROLE_ADMIN") {
            this.$store.commit("logout");
          }
        } else {
          this.$message.error(res.msg);
        }
      });
  },

  selectMenu(role) {
    this.roleId = role.id;
    this.roleFlag = role.flag;

    // 请求菜单数据
    this.request.get("/menu").then((res) => {
      this.menuData = res.data;

      // 把后台返回的菜单数据处理成 id数组
      this.expends = this.menuData.map((v) => v.id);
    });

    this.request.get("/role/roleMenu/" + this.roleId).then((res) => {
      this.checks = res.data;

      this.request.get("/menu/ids").then((r) => {
        const ids = r.data;
        ids.forEach((id) => {
          if (!this.checks.includes(id)) {
            this.$refs.tree.setChecked(id, false);
          }
        });
      });
      this.menuDialogVis = true;
    });
  },
};
</script>

<style></style>
