<template>
  <el-card class="box-card-list">
    <el-table ref="multipleTable" class="mt-10" :data="tableData" :row-class-name="tableRowClassName">
      <el-table-column prop="auReason" label="修改内容"> </el-table-column>
      <el-table-column prop="auState" label="审核进度"> </el-table-column>
      <el-table-column prop="auResult" label="审核结果"> </el-table-column>
      <el-table-column prop="aaccount" label="处理人"> </el-table-column>
      <el-table-column prop="updateTime" label="处理时间"> </el-table-column>
    </el-table>
    <el-pagination
      class="pagediv"
      @size-change="handleSizeChange"
      @current-change="handleCurrentChange"
      :current-page="pageNum"
      :page-sizes="[5, 10, 15, 20]"
      :page-size="pageSize"
      layout="total, sizes, prev, pager, next, jumper"
      :total="total"
    >
    </el-pagination>
  </el-card>
</template>
<script>
export default {
  created() {
    this.load();
  },
  methods: {
    load() {
      this.request.get("/auuser/pageuid", {
        params: {
          pageNum: this.pageNum,
          pageSize: this.pageSize,
          uid: this.user.userId
        },
      }).then((res) => {
        this.tableData = res.data.records;
        this.total = res.data.total;
      });
    },
    tableRowClassName({row, rowIndex}) {
      if (row.auResult === "已拒绝") {
          return 'warning-row';
        } else if (row.auResult === "已通过") {
          return 'success-row';
        }
        return '';
    },
    // 更改每页大小
    handleSizeChange(pageSize) {
      this.pageSize = pageSize;
      this.load();
    },
    // 更改页码
    handleCurrentChange(pageNum) {
      this.pageNum = pageNum;
      this.load();
    },
  },
  data() {
    return {
      user: localStorage.getItem("user") ? JSON.parse(localStorage.getItem("user")) : {},
      tableData: [],
      total: 0,
      pageNum: 1,
      pageSize: 5,
    };
  },
};
</script>

<style scoped></style>
