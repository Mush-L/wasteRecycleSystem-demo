<template>
  <el-card class="box-card">
    <el-descriptions class="margin-top" title="任务详情" :column="3" border>
      <el-descriptions-item label="物品ID">{{ info.wid }}</el-descriptions-item>
      <el-descriptions-item label="名称">{{ info.wname }}</el-descriptions-item>
      <el-descriptions-item label="归属用户">{{ info.uid }}</el-descriptions-item>
      <el-descriptions-item label="种类">{{ info.wtype1 }}</el-descriptions-item>
      <el-descriptions-item label="分类">{{ info.wtype2 }}</el-descriptions-item>
      <el-descriptions-item label="详情">{{ info.wtype3 }}</el-descriptions-item>
      <el-descriptions-item label="重量">{{ info.ww }} kg</el-descriptions-item>
      <el-descriptions-item label="体积">{{ info.wv }} m³</el-descriptions-item>
      <el-descriptions-item>&#12288;</el-descriptions-item>
      <el-descriptions-item label="备注">{{ info.wdesc }}</el-descriptions-item>
    </el-descriptions>
    <el-descriptions class="margin-top mt--1" :column="3" border>
      <el-descriptions-item label="预约日期">{{ info.tdate }}</el-descriptions-item>
      <el-descriptions-item label="地区">{{ info.taddress1 }}</el-descriptions-item>
      <el-descriptions-item label="地址">{{ info.taddress2 }}</el-descriptions-item>
      <el-descriptions-item label="备注">{{ info.tdesc }}</el-descriptions-item>
    </el-descriptions>
  </el-card>
</template>

<script>

export default {
  created() {
    this.info = this.$route.params.info;
  },
};
</script>

<style scoped>
</style>
