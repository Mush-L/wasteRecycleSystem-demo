<template>
  <el-card class="box-card-list">
    <el-table ref="multipleTable" :data="tableData" style="margin-top: 10px">
      <el-table-column type="selection"> </el-table-column>
      <el-table-column width="80" prop="uid" label="用户ID"> </el-table-column>
      <el-table-column prop="auReason" label="修改内容"> </el-table-column>
      <el-table-column width="100" fixed="right" label="操作">
        <template slot-scope="scope">
          <el-button @click.native.prevent="detail(scope.$index, tableData)" type="text" size="small" > 查看</el-button>
        </template>
      </el-table-column>
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
      this.request
        .get("/auuser/page", {
          params: {
            pageNum: this.pageNum,
            pageSize: this.pageSize
          },
        })
        .then((res) => {
          this.tableData = res.data.records;
          this.total = res.data.total;
        });
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
    search() {
      this.pageNum = 1;
      this.pageSize = 5;
      this.load();
    },
    detail(index, rows) {
      this.$router.push({
        name: "adminAuditUserInfo",
        params: {
          info: rows[index],
        },
      });
    },
  },
  data() {
    return {
      tableData: [],
      total: 0,
      pageNum: 1,
      pageSize: 5,
    };
  },
};
</script>

<style scoped>
.pagediv {
  margin-top: 20px;
  text-align: center;
}
</style>
