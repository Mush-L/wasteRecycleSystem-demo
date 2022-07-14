<template>
  <el-card class="box-card">
    <div slot="header">
      <span>更新信息</span>
    </div>
    <el-form ref="form" :model="form" label-width="80px">
      <el-row>
        <el-col :span="12">
          <el-form-item label="账号">
            {{ form.userAccount }}
          </el-form-item>
        </el-col>
        <el-col :span="12">
          <el-form-item label="密码">
            <el-input v-model="form.userPassword" show-password></el-input>
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
        <el-button type="primary" @click="onSubmit">更新</el-button>
        <el-button @click="cancle">取消</el-button>
      </div>
    </el-form>
  </el-card>
</template>

<script>
export default {
  data() {
    return {
      form: "",
    };
  },
  created(){
    this.form=this.$route.params.info;
  },
  methods: {
    onSubmit() {
      this.request.post("/user", this.form).then((res) => {
        if (res) {
          this.$message.success("保存成功");
          this.$router.push({ name: "userInfo" });
        } else {
          this.$message.error("保存失败");
        }
      });
    },
    cancle(value) {
      this.$router.push({ name: "userInfo" });
    },
  },
};
</script>

<style scoped>

</style>
