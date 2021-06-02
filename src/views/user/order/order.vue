<template>
  <div class="container">
    <div class="myheader">
      <tabbar></tabbar>
    </div>
    <div style="width: 100%;display: flex;justify-content: center;margin-top: 15px">
      <el-card style="width: 58%">
        <div slot="header" class="clearfix">
          <span style="font-size: 20px">我的订单</span>
        </div>
        <div v-for="(item,index) in orderList" :key="index" style="background-color:#f4f4f4;margin: 0 0 10px 0;padding: 12px;border-radius: 10px">
          <div style="display: flex;align-items: center;justify-content: space-between">
            <div style="display: flex;align-items: center">
              <div style="font-size: 20px;margin-right: 10px">订单编号:</div>
              <div style="color: #D81E06;font-size: 24px">{{ item.serialNumber }}</div>
            </div>
            <div v-if="item.status == 0">
              <div style="color: chocolate;font-size: 12px">未发货</div>
            </div>
            <div v-if="item.status == 1">
              <div style="color: darkblue;font-size: 12px">已发货</div>
            </div>
            <div v-if="item.status == 2">
              <div style="color: green;font-size: 12px">已确认收货</div>
            </div>
          </div>
          <div v-for="(item2,index2) in item.children" style="display: flex;justify-content: space-between;align-items: center;margin: 5px 0 3px 0" @click="toGoodInfo(item2.seafood.id)">
            <div>
              <img :src="baseUrl+item2.seafood.pics[0].name" width="120px" height="80px"/>
            </div>
            <div style="font-size: 20px;color: #999999;max-width: 70%">{{item2.seafood.name}}</div>
            <div style="font-size: 20px;color: black;max-width: 70%">￥{{item2.seafood.outPrice}}</div>
            <div style="display: flex">
              <div>x</div>
              <div>{{ item2.count }}</div>
            </div>
          </div>
          <div style="display: flex;justify-content: space-between;align-items: center">
            <div>{{item.createDate.substring(0,19).replace("T"," ")}}</div>
            <div style="display: flex;align-items: center">
              <div style="color: #999999;margin-right: 15px">总价:￥{{item.cost}}</div>
              <div style="color: black;font-size: 20px">实付:￥{{item.pay}}</div>
            </div>
          </div>
        </div>
      </el-card>
    </div>
  </div>

</template>

<script>
import tabbar from "../../../components/user/tabbar";
import * as order from "../../../network/admin/order/order"
import * as good from "../../../network/admin/good/goods"

export default {
  components: {
    tabbar
  },
  name: "order",
  data() {
    return {
      orderList: [],
      baseUrl: good.pic_url,
      payData:""
    }
  },
  mounted() {
    this.getOrder();
  },
  methods: {
    getOrder() {
      order.getOrderByUser(window.localStorage.getItem("userId")).then(res => {
        this.orderList = res.data.data
      }).catch(err => {
        console.log(err);
      })
    },
    toGoodInfo(id){
      this.$router.push({path:"/goodInfo",query:{goodId:id}})
    },
    toPay(){

    },
  }
}
</script>

<style scoped>
.header {
  width: auto !important;
}

.container {
  display: flex;
  flex-direction: column;
}

.myheader {
  display: flex;
  width: 100%;
  position: sticky;
  left: 0;
  right: 0;
  top: 0;
  z-index: 50;
  flex-direction: column;
}

</style>
