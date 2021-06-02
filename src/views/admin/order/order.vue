<template>
  <div>
    <div>
      <el-breadcrumb separator="/">
        <el-breadcrumb-item>当前位置:</el-breadcrumb-item>
        <el-breadcrumb-item>订单管理</el-breadcrumb-item>
        <el-breadcrumb-item>订单列表</el-breadcrumb-item>
      </el-breadcrumb>
    </div>
    <el-card style="margin-top: 15px;">
      <div style="display: flex">
        <el-input clearable placeholder="流水号" style="width: 10%" v-model="search.serialNumber" size="mini"></el-input>
        <el-date-picker v-model="search.lowDate" type="date" placeholder="最低日期" size="mini"></el-date-picker>
        <el-date-picker v-model="search.highDate" type="date" placeholder="最高日期" size="mini"></el-date-picker>
        <el-select size="mini" v-model="search.status" placeholder="订单状态" clearable>
          <el-option
            v-for="item in options"
            :key="item.value"
            :label="item.label"
            :value="item.value">
          </el-option>
        </el-select>
        <el-button type="primary" icon="el-icon-search" @click="getOrder" size="mini">搜索</el-button>
      </div>
      <!--      表格-->
      <el-table :data="orderList" style="width: 100%;margin-top: 10px;" border>
        <el-table-column type="expand">
          <template slot-scope="item">
            <div v-for="(item2,index2) in item.row.children"
                 style="display: flex;justify-content: space-between;align-items: center;margin: 5px 0 3px 0">
              <div>
                <img :src="baseUrl+item2.seafood.pics[0].name" width="120px" height="80px"/>
              </div>
              <div style="font-size: 20px;color: #999999;max-width: 70%;">{{ item2.seafood.name }}</div>
              <div style="font-size: 20px;color: black;max-width: 70%;">￥{{ item2.seafood.outPrice }}</div>
              <div style="display: flex">
                <div>x</div>
                <div>{{ item2.count }}</div>
              </div>
            </div>
          </template>
        </el-table-column>
        <el-table-column prop="#" type="index"></el-table-column>
        <el-table-column prop="userId" label="用户ID"></el-table-column>
        <el-table-column prop="serialNumber" label="流水号"></el-table-column>
        <el-table-column prop="cost" label="价值"></el-table-column>
        <el-table-column prop="pay" label="实付"></el-table-column>
        <el-table-column prop="userAddr" label="地址"></el-table-column>
        <el-table-column prop="realName" label="收货人"></el-table-column>
        <el-table-column prop="createDate" label="发起时间">
          <template slot-scope="scope">
            {{ scope.row.createDate.substring(0, 19).replace("T", " ") }}
          </template>
        </el-table-column>
        <el-table-column prop="createDate" label="状态">
          <template slot-scope="scope">
            <el-tag size="mini" type="danger" style="margin-right: 15px" v-if="scope.row.status == 0">未发货</el-tag>
            <el-button size="mini" v-if="scope.row.status == 0" type="primary" class="el-icon-truck" circle
                       @click="updateOrder(scope.row.id)"></el-button>
            <el-tag size="mini" type="warning" v-if="scope.row.status == 1">已发货</el-tag>
            <el-tag size="mini" type="success" v-if="scope.row.status == 2">已签收</el-tag>
          </template>
        </el-table-column>
      </el-table>
      <div class="block" style="margin-top: 15px">
        <el-pagination
          @size-change="handleSizeChange"
          @current-change="handleCurrentChange"
          :current-page="currentPage4"
          :page-sizes="[10, 50, 100]"
          :page-size="search.pageSize"
          layout="total, sizes, prev, pager, next, jumper"
          :total="allSize">
        </el-pagination>
      </div>
    </el-card>
  </div>

</template>

<script>
import * as order from "../../../network/admin/order/order"
import * as good from "../../../network/admin/good/goods"

export default {
  name: "order",
  data() {
    return {
      orderList: [],
      baseUrl: good.pic_url,
      search: {
        serialNumber: "",
        lowDate: "",
        highDate: "",
        pageNo: 1,
        pageSize: 10,
        status:""
      },
      currentPage4: 1,
      allSize: "",
      options: [
        {
          value: '0',
          label: '未发货'
        }, {
          value: '1',
          label: '已发货'
        }, {
          value: '2',
          label: '已签收'
        }
      ],
    }
  },
  mounted() {
    this.getOrder()
  },
  methods: {
    getOrder() {
      order.getAllOrder(this.search.serialNumber, this.search.lowDate, this.search.highDate,
        this.search.pageNo, this.search.pageSize,this.search.status).then(res => {
        this.orderList = res.data.data.list;
        this.allSize = res.data.data.total
      })
    },
    handleSizeChange(val) {
      this.search.pageSize = val;
      this.getOrder();
    },
    handleCurrentChange(val) {
      this.search.pageNo = val;
      this.getOrder();
    },
    updateOrder(id) {
      order.updateOrder(id).then(res => {
        this.$message.success(res.data.message);
        this.getOrder();
      })
    }
  }
}
</script>

<style scoped>

</style>
