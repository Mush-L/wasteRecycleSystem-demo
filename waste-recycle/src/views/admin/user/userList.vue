<template>
  <el-card class="box-card-list">
    <!-- 内容页的顶部功能 -->
    <el-row type="flex" justify="start" v-model="searchParams">
      <el-input
        v-model="searchParams.name"
        placeholder="请输入姓名"
        style="margin-left: 15px"
      >
      </el-input>
      <el-input
        v-model="searchParams.phone"
        placeholder="请输入电话"
        style="margin-left: 10px"
      >
      </el-input>

      <el-button type="primary" @click="search" style="margin-left: 10px"
        >查询</el-button
      >
      <el-button type="info" @click="reset">重置</el-button>
    </el-row>
    <!-- 在内容页中将信息展示出来 -->
    <el-table ref="multipleTable" :data="tableData" style="margin-top: 10px">
      <el-table-column type="selection"> </el-table-column>
      <el-table-column width="50" prop="userId" label="ID"> </el-table-column>
      <el-table-column prop="userName" label="姓名"> </el-table-column>
      <el-table-column prop="userSex" label="性别"> </el-table-column>
      <el-table-column prop="userAge" label="年龄"> </el-table-column>
      <el-table-column prop="userPhone" label="手机号"> </el-table-column>
      <el-table-column fixed="right" label="操作">
        <!-- 根据 id 检索单个用户的信息 -->
        <template slot-scope="scope">
          <el-button
            @click.native.prevent="detail(scope.$index, tableData)"
            type="text"
            size="small"
          >
            查看</el-button
          >
          <el-button
            @click.native.prevent="del(scope.row.userId)"
            type="text"
            style="color: #ff3c33"
            size="small"
          >
            删除</el-button
          >
        </template>
      </el-table-column>
    </el-table>
    <!-- 分页 -->
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
  // 创建页面时，向后台请求数据
  created() {
    // 动态向后台请求
    this.load();
    // 请求前端本地数据
    // this.localHuoqu();
  },

  methods: {
    // 本地获取，不调用后台
    localHuoqu() {
      this.tableData = this.tableDataList;
    },

    // 请求分页查询数据
    load() {
      this.request
        .get("/user/page", {
          params: {
            pageNum: this.pageNum,
            pageSize: this.pageSize,
            username: this.searchParams.name,
            phone: this.searchParams.phone,
          },
        })
        .then((res) => {
          // console.log(res);
          this.tableData = res.data.records;
          this.total = res.data.total;
        });
      // 使用 fetch 请求后台
      // fetch(
      //   "http://localhost:9090/user/page?pageNum=" +
      //     this.pageNum +
      //     "&pageSize=" +
      //     this.pageSize
      // )
      //   .then((res) => res.json())
      //   .then((res) => {
      //     // console.log(res);
      //     this.tableData = res.data;
      //     this.total = res.total;
      //   });
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
    // 删除数据
    del(id) {
      this.$confirm("此操作将永久删除该数据, 是否继续?", "提示", {
        confirmButtonText: "确定",
        cancelButtonText: "取消",
        type: "warning",
      })
        .then(() => {
          this.request.delete("/user/" + id).then((res) => {
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
    // 清除选择
    reset() {
      this.searchParams.name = null;
      this.searchParams.phone = null;
      this.load();
    },
    // 这里是查看的按钮的方法，会将当前对象发送给下个页面
    // 注意如果要向别的组件发送数据，一定不能使用path来跳转，需要使用在路由中配置的name属性来跳转
    detail(index, rows) {
      this.$router.push({
        name: "adminUserInfo",
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
        phone: "",
      },
      // 前端展示的数据
      tableData: [],
      // 分页查询，数据总数
      total: 0,
      pageNum: 1,
      pageSize: 5,

      // 静态数据填写表格
      tableDataList: [
        {
          userId: "0001",
          userAccount: "mufeng",
          userName: "木风",
          userSex: "男",
          userAge: "23",
          userPhone: "15634560988",
        },
        {
          userId: "0002",
          userAccount: "qianyu",
          userName: "千羽",
          userSex: "男",
          userAge: "22",
          userPhone: "15634560988",
        },
        {
          userId: "0003",
          userAccount: "luoshaocheng",
          userName: "罗韶程",
          userSex: "男",
          userAge: "35",
          userPhone: "15634560988",
        },
        {
          userId: "0005",
          userAccount: "hapiluo",
          userName: "哈皮罗",
          userSex: "女",
          userAge: "26",
          userPhone: "15634560988",
        },
        {
          userId: "0018",
          userAccount: "yingfei",
          userName: "嬴非",
          userSex: "男",
          userAge: "43",
          userPhone: "15634560988",
        },
      ],
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
