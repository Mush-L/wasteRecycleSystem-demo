<template>
  <el-card class="box-card-list">
    <el-row type="flex" justify="start" v-model="searchParams">
      <el-input class="ml-10" v-model="searchParams.name" placeholder="请输入名称"></el-input>
      <el-input class="ml-10" v-model="searchParams.tp2" placeholder="请输入分类"></el-input>
      <el-input class="ml-10" v-model="searchParams.tp3" placeholder="详情"></el-input>
      <el-button type="primary" @click="search" style="margin-left: 10px">查询</el-button>
      <el-button type="info" @click="reset">重置</el-button>
    </el-row>
    <el-table ref="multipleTable" :data="tableData" style="margin-top: 10px">
      <el-table-column type="selection"> </el-table-column>
      <el-table-column width="50" prop="wid" label="ID"> </el-table-column>
      <el-table-column prop="wname" label="名称"> </el-table-column>
      <el-table-column prop="wtype2" label="分类"> </el-table-column>
      <el-table-column prop="wtype3" label="详情"> </el-table-column>
      <el-table-column width="90" prop="ww" label="重量(kg)"> </el-table-column>
      <el-table-column width="90" prop="wv" label="体积(m³)"> </el-table-column>
      <el-table-column fixed="right" label="操作">
        <template slot-scope="scope">
          <el-button @click.native.prevent="detail(scope.$index, tableData)" type="text" size="small">查看</el-button>
          <el-button @click.native.prevent="del(scope.row.wid)" type="text" style="color: #ff3c33" size="small">删除</el-button>
        </template>
      </el-table-column>
    </el-table>
    <el-pagination class="pagediv" @size-change="handleSizeChange" @current-change="handleCurrentChange"
      :current-page="pageNum" :page-sizes="[5, 10, 15, 20]" :page-size="pageSize" :total="total"
      layout="total, sizes, prev, pager, next, jumper">
    </el-pagination>
  </el-card>
</template>
<script>
export default {
  created() {
    this.search();
  },

  methods: {
    load() {
      this.request
        .get("/waste/page", {
          params: {
            pageNum: this.pageNum,
            pageSize: this.pageSize,
            wname: this.searchParams.name,
            wtype2: this.searchParams.tp2,
            wtype3: this.searchParams.tp3,
          },
        })
        .then((res) => {
          this.tableData = res.data.records;
          this.total = res.data.total;
        });
    },
    handleSizeChange(pageSize) {
      this.pageSize = pageSize;
      this.load();
    },
    handleCurrentChange(pageNum) {
      this.pageNum = pageNum;
      this.load();
    },
    del(id) {
      this.$confirm("此操作将永久删除该数据, 是否继续?", "提示", {
        confirmButtonText: "确定",
        cancelButtonText: "取消",
        type: "warning",
      })
        .then(() => {
          this.request.delete("/waste/" + id).then((res) => {
            if (res.code==="200") {
              this.$message.success("删除成功");
              this.load();
            } else {
              this.$message.error("删除失败");
            }
          });
        })
        .catch(() => {
          this.$message({
            type: "info",
            message: "已取消删除",
          });
        });
    },
    search() {
      this.pageNum = 1;
      this.pageSize = 5;
      this.load();
    },
    reset() {
      this.searchParams.name = null;
      this.searchParams.tp2 = null;
      this.searchParams.tp3 = null;
      this.load();
    },
    detail(index, rows) {
      this.$router.push({
        name: "adminWasteInfo",
        params: {
          info: rows[index],
        },
      });
    },
  },
  data() {
    return {
      // 向后端发送的搜索
      searchParams: {
        name: "",
        tp2: "",
        tp3: "",
      },
      // 前端展示的数据
      tableData: [],
      // 分页查询，数据总数
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
