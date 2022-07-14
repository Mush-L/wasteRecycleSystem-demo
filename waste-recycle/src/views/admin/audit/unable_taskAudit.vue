<template>
  <el-card class="box-card-list">
    <!-- 内容页的顶部功能 -->
    <el-row type="flex" justify="start" v-model="searchParams">
      <el-input
        v-model="searchParams.id"
        placeholder="请输入用户ID"
        style="margin-left: 15px"
      >
      </el-input>
      <el-input
        v-model="searchParams.name"
        placeholder="请输入物品ID"
        style="margin-left: 10px"
      >
      </el-input>

      <el-button type="primary" @click="serach" style="margin-left: 10px"
        >查询</el-button
      >
      <el-button type="danger" @click="cancle" size="small">清除选择</el-button>
    </el-row>
    <!-- 在内容页中将信息展示出来 -->
    <el-table ref="multipleTable" :data="tableData" style="margin-top: 10px">
      <el-table-column type="selection"> </el-table-column>
      <el-table-column prop="taskId" label="任务ID"> </el-table-column>
      <el-table-column prop="wasteName" label="物品名称"> </el-table-column>
      <el-table-column prop="taskDate" label="发布时间"> </el-table-column>
      <el-table-column prop="auditState" label="状态"> </el-table-column>
      <el-table-column prop="taskDesc" label="备注"> </el-table-column>

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
        </template>
      </el-table-column>
    </el-table>
    <!-- 分页 -->
    <el-pagination
      background
      layout="prev, pager, next"
      :total="1000"
      class="pagediv"
    >
    </el-pagination>
  </el-card>
</template>
<script>
export default {
  // 创建页面时，向后台请求数据
  created() {
    // 动态向后台请求
    // this.huoqu();
    // 请求前端本地数据
    this.localHuoqu();
  },

  methods: {
    // 本地获取，不调用后台
    localHuoqu() {
      this.tableData = this.tableDataList;
    },
    // 获取后台数据的方法：
    huoqu() {
      this.axios
        .request({
          headers: { "Access-Control-Allow-Origin": "*" },
          url: "http://192.168.30.45:8080/project02/register/show",
          methods: "get",
        })
        .then((res) => {
          this.tableData = res.data;
        });
    },

    cancle() {
      this.searchParams.name = null;
      this.searchParams.id = null;
      this.huoqu();
    },
    // 这里是查看的按钮的方法，会将当前对象发送给下个页面
    // 注意如果要向别的组件发送数据，一定不能使用path来跳转，需要使用在路由中配置的name属性来跳转
    detail(index, rows) {
      // 传入的对象
      this.$router.push({
        // 当点击查看时，将数据传递给info页面
        name: "adminAuditTaskInfo",
        params: {
          info: rows[index],
        },
      });
    },
    serach() {
      // 这是将input数据传递给后端
      this.axios
        .request({
          headers: { "Access-Control-Allow-Origin": "*" },
          url: "http://192.168.30.45:8080/project02/register/sql",
          methods: "post",
          params: {
            ...this.searchParams,
          },
        })
        .then((res) => {
          this.tableData = res.data;
        });
    },
  },
  data() {
    return {
      searchParams: {
        id: "",
        name: "",
      },
      // 将后台中获取的数据进行处理
      tableData: [],

      //这里先用静态数据填写表格
      tableDataList: [
        {
          taskId: "1",
          userId: "1",
          wasteId: "2",
          wasteName: "呆呆罗",
          taskDate: "2022-03-15",
          taskAddress: "江苏省镇江市丹徒区江科大",
          taskDate2: "2022-03-15",
          taskAddress2: "江苏省镇江市丹徒区江科大",
          auditState: "未完成",
          taskDesc: "修改地点",
        },
        {
          taskId: "2",
          userId: "1",
          wasteId: "2",
          wasteName: "呆罗兽",
          taskDate: "2022-03-22",
          taskAddress: "江苏省镇江市丹徒区江科大",
          taskDate2: "2022-04-23",
          taskAddress2: "江苏省镇江市丹徒区江科大",
          auditState: "未完成",
          taskDesc: "修改时间",
        },
        {
          taskId: "3",
          userId: "1",
          wasteId: "2",
          wasteName: "饮料瓶",
          taskDate: "2022-03-29",
          taskAddress: "江苏省镇江市丹徒区江科大",
          taskDate2: "2022-03-29",
          taskAddress2: "江苏省镇江市丹徒区江科大",
          auditState: "已完成",
          taskDesc: "删除任务",
        },
        {
          taskId: "4",
          userId: "1",
          wasteId: "2",
          wasteName: "旧鼠标",
          taskDate: "2022-04-15",
          taskAddress: "江苏省镇江市丹徒区江科大",
          taskDate2: "2022-04-15",
          taskAddress2: "江苏省镇江市丹徒区江科大",
          auditState: "未完成",
          taskDesc: "任务发布重复",
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
