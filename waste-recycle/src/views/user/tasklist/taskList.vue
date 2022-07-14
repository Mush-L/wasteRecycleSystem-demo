<template>
  <el-card class="box-card-list">
    <el-row type="flex" justify="start" v-model="searchParams">
      <el-input class="ml-10" v-model="searchParams.name" placeholder="请输入名称"></el-input>
      <el-input class="ml-10" v-model="searchParams.tp2" placeholder="请输入种类"></el-input>
      <el-input class="ml-10" v-model="searchParams.add1" placeholder="请输入地区"></el-input>
      <el-button type="primary" @click="search" style="margin-left: 10px">查询</el-button>
      <el-button type="info" @click="reset">重置</el-button>
    </el-row>
    <el-table ref="multipleTable" :data="tableData" style="margin-top: 10px">
      <el-table-column type="selection"> </el-table-column>
      <el-table-column width="50" prop="wid" label="编号"> </el-table-column>
      <el-table-column width="80" prop="uid" label="用户ID"> </el-table-column>
      <el-table-column prop="wname" label="物品名"> </el-table-column>
      <el-table-column prop="wtype2" label="种类"> </el-table-column>
      <el-table-column prop="tdate" label="预约日期"> </el-table-column>
      <el-table-column width="160" prop="taddress1" label="地区"> </el-table-column>
      <el-table-column prop="tstate" label="状态"> </el-table-column>
      <el-table-column fixed="right" label="操作">
        <template slot-scope="scope">
          <el-button @click.native.prevent="detail(scope.$index, tableData)" type="text" size="small">查看</el-button>
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
            taddress1: this.searchParams.add1,
            taddress2: this.searchParams.add2,
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
    search() {
      this.pageNum = 1;
      this.pageSize = 5;
      this.load();
    },
    reset() {
      this.searchParams.name = null;
      this.searchParams.tp2 = null;
      this.searchParams.tp3 = null;
      this.searchParams.add1 = null;
      this.searchParams.add2 = null;
      this.load();
    },
    detail(index, rows) {
      this.$router.push({
        name: "userTaskInfo",
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
        ty2: "",
        tp3: "",
        add1: "",
        add2: "",
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
