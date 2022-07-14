<template>
  <el-card class="box-card">
    <el-descriptions class="margin-top" title="旧数据" :column="3" border>
      <el-descriptions-item label="任务ID">{{
        this.$route.params.info.taskId
      }}</el-descriptions-item>
      <el-descriptions-item label="用户ID">{{
        this.$route.params.info.userId
      }}</el-descriptions-item>
      <el-descriptions-item label="物品ID">{{
        this.$route.params.info.wasteId
      }}</el-descriptions-item>
      <el-descriptions-item label="物品名称">{{
        this.$route.params.info.wasteName
      }}</el-descriptions-item>
      <el-descriptions-item label="发布时间">{{
        this.$route.params.info.taskDate
      }}</el-descriptions-item>
      <el-descriptions-item label="地点">{{
        this.$route.params.info.taskAddress
      }}</el-descriptions-item>
      <el-descriptions-item label="修改原因">{{
        this.$route.params.info.taskDesc
      }}</el-descriptions-item>
    </el-descriptions>

    <div class="mid-line"></div>

    
    <el-descriptions class="margin-top" title="新数据" :column="3" border>
      <el-descriptions-item label="任务ID">{{
        this.$route.params.info.taskId
      }}</el-descriptions-item>
      <el-descriptions-item label="用户ID">{{
        this.$route.params.info.userId
      }}</el-descriptions-item>
      <el-descriptions-item label="物品ID">{{
        this.$route.params.info.wasteId
      }}</el-descriptions-item>
      <el-descriptions-item label="物品名称">{{
        this.$route.params.info.wasteName
      }}</el-descriptions-item>
      <el-descriptions-item label="发布时间">{{
        this.$route.params.info.taskDate2
      }}</el-descriptions-item>
      <el-descriptions-item label="地点">{{
        this.$route.params.info.taskAddress2
      }}</el-descriptions-item>
    </el-descriptions>

    <el-row class="mid-line">
      <el-button type="primary">确认</el-button>
      <el-button type="danger">拒绝</el-button>
    </el-row>
  </el-card>
</template>

<script>
export default {};
</script>

<style scoped>
.mid-line {
  margin-top: 20px;
  text-align: center;
}
</style>
