<template>
  <div>
    <el-card v-show="isShow1" class="box-card">
      <el-descriptions class="margin-top" title="用户详情" :column="3" border>
        <template slot="extra">
          <el-button
            type="success"
            icon="el-icon-edit"
            @click="edit"
            size="small"
            >编辑</el-button
          >
        </template>
        <el-descriptions-item label="ID">{{
          this.$route.params.info.userId
        }}</el-descriptions-item>
        <el-descriptions-item label="账号">{{
          this.$route.params.info.userAccount
        }}</el-descriptions-item>
        <el-descriptions-item label="姓名">{{
          this.$route.params.info.userName
        }}</el-descriptions-item>
        <el-descriptions-item label="性别">{{
          this.$route.params.info.userSex
        }}</el-descriptions-item>
        <el-descriptions-item label="年龄">{{
          this.$route.params.info.userAge
        }}</el-descriptions-item>
        <el-descriptions-item label="手机号">{{
          this.$route.params.info.userPhone
        }}</el-descriptions-item>
      </el-descriptions>
    </el-card>

    <el-card v-show="isShow2" class="box-card">
      <div slot="header">
        <span>更新信息</span>
      </div>
      <el-form ref="form" :model="form" label-width="80px">
        <el-row>
          <el-col :span="12">
            <el-form-item label="ID">
              {{ form.userId }}
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="账号">
              {{ form.userAccount }}
            </el-form-item>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="12">
            <el-form-item label="姓名">
              <el-input v-model="form.userName"></el-input>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="电话">
              <el-input v-model="form.userPhone"></el-input>
            </el-form-item>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="12">
            <el-form-item label="性别">
              <el-select v-model="form.userSex" placeholder="请选择性别">
                <el-option label="保密" value="保密"></el-option>
                <el-option label="男" value="男"></el-option>
                <el-option label="女" value="女"></el-option>
              </el-select>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="年龄">
              <el-input v-model="form.userAge"></el-input>
            </el-form-item>
          </el-col>
        </el-row>
        <div class="mid-line">
          <el-button type="primary" size="small" @click="onSubmit"
            >保存</el-button
          >
          <el-button size="small" @click="cancle">取消</el-button>
        </div>
      </el-form>
    </el-card>
  </div>
</template>

<script>
export default {
  created() {
    this.form = this.$route.params.info;
  },
  methods: {
    edit() {
      this.isShow1 = false;
      this.isShow2 = true;
    },

    onSubmit() {
      this.request.post("/user", this.form).then((res) => {
        if (res) {
          this.$message.success("保存成功");
          this.$router.push({ name: "adminUser" });
        } else {
          this.$message.error("保存失败");
        }
      });
    },
    cancle() {
      this.$router.push({ name: "adminUser" });
    },
  },
  data() {
    return {
      form0: [],
      form: [],
      isShow1: true,
      isShow2: false,
    };
  },
};
</script>

<style scoped></style>
