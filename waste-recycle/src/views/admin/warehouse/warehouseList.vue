<template>
  <el-card class="box-card-list">
    <el-row type="flex" justify="start" v-model="searchParams">
      <el-input class="ml-10" v-model="searchParams.tp2" placeholder="请输入分类"></el-input>
      <el-input class="ml-10" v-model="searchParams.tp3" placeholder="详情"></el-input>
      <el-input class="ml-10" v-model="searchParams.inadmin" placeholder="入库管理员"></el-input>
      <el-button type="primary" @click="search" style="margin-left: 10px">查询</el-button>
      <el-button type="info" @click="reset">重置</el-button>
    </el-row>
    <el-table ref="multipleTable" :data="tableData" style="margin-top: 10px">
      <el-table-column type="selection"> </el-table-column>
      <el-table-column width="80" prop="waId" label="仓库ID"> </el-table-column>
      <el-table-column prop="wname" label="名称"> </el-table-column>
      <el-table-column prop="wtype2" label="分类"> </el-table-column>
      <el-table-column prop="wtype3" label="详情"> </el-table-column>
      <el-table-column width="200" prop="createTime" label="入库时间"> </el-table-column>
      <el-table-column prop="inAdmin" label="入库管理员"> </el-table-column>
      <el-table-column width="90" prop="ww" label="重量(kg)"> </el-table-column>
      <el-table-column width="90" prop="wv" label="体积(m³)"> </el-table-column>
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
        .get("/warehouse/page", {
          params: {
            pageNum: this.pageNum,
            pageSize: this.pageSize,
            wtype2: this.searchParams.tp2,
            wtype3: this.searchParams.tp3,
            inAdmin: this.searchParams.inadmin,
            wastate: this.searchParams.state,
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
      this.searchParams={};
      this.load();
    },
    detail(index, rows) {
      this.$router.push({
        name: "adminWarehouseWasteInfo",
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
        tp2: "",
        tp3: "",
        inadmin: "",
        state: "",
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
