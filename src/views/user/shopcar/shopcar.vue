<template>
  <div class="container">
    <div class="myheader">
      <tabbar></tabbar>
    </div>
    <div style="width: 100%;display: flex;justify-content: center;margin-top: 15px">
      <el-card style="width: 60%">
        <div slot="header" class="clearfix">
          <span style="font-size: 20px">购物车</span>
        </div>
        <div>
          <el-table
            :data="shopcarList" @selection-change="handleSelectionChange"
            style="width: 100%">
            <el-table-column type="selection"></el-table-column>
            <el-table-column type="index" label="#"></el-table-column>
            <el-table-column label="商品详情" width="130px">
              <template slot-scope="scope">
                <img style="display: block" width="120px" height="80px" :src="baseUrl+scope.row.seafood.pics[0].name">
              </template>
            </el-table-column>

            <el-table-column>
              <template slot-scope="scope" style="display: flex;flex-direction: row">
                <div style="display: flex">名称：<p style="color: #999999;">{{ scope.row.seafood.name }}</p></div>
                <div style="display: flex">售价：<p style="color: #D81E06;font-size: 20px">{{
                    scope.row.seafood.outPrice
                  }}</p></div>
              </template>
            </el-table-column>

            <el-table-column label="数量">
              <template slot-scope="scope" style="display: flex;flex-direction: row">
                <el-input-number v-model="scope.row.count" @change="countChange" :min="50" :max="100" :step="10"
                                 label="描述文字"></el-input-number>
              </template>
            </el-table-column>

            <el-table-column label="操作" width="70px">
              <template slot-scope="scope">
                <el-button @click="deleteGoodFromCar(scope)" type="text">移除</el-button>
              </template>
            </el-table-column>
          </el-table>
        </div>
        <div style="display: flex;align-items: center;margin-top: 15px">
          <div style="font-size: 14px;color: #999999;margin-right: 7px">收货地址</div>
          <el-select v-model="addr" placeholder="选择收货地址">
            <el-option v-for="item in addrList"
                       :key="item.id"
                       :label="item.addr"
                       :value="item.id"></el-option>
          </el-select>
        </div>
        <div style="display: flex;justify-content: space-between;align-items: center">
          <div style="display: flex">
            <div style="display: flex;align-items: center">
              <div>总计</div>
              <div style="color: #D81E06;font-size: 16px;margin: 0 10px;text-decoration: line-through">{{ allPrice }}</div>
            </div>
            <div style="display: flex;align-items: center">
              <div>应付</div>
              <div style="color: #D81E06;font-size: 25px;margin-left: 10px">{{ allPrice * 0.8 }}</div>
            </div>
          </div>
          <el-button type="danger" style="margin-top: 15px;display: flex;justify-content: flex-end" @click="toPay">立即付款</el-button>
        </div>
      </el-card>
    </div>
  </div>
</template>

<script>
import tabbar from "../../../components/user/tabbar";
import * as user from "../../../network/admin/user/user"
import * as good from "../../../network/admin/good/goods"
import * as order from "../../../network/admin/order/order"

export default {
  components: {
    tabbar
  },
  name: "shopcar",
  data() {
    return {
      shopcarList: [],
      baseUrl: good.pic_url,
      allPrice: 0,
      multipleSelection: [],
      addrList: [],
      addr: "",
      orderName:"海鲜商城商品",
      orderInfo:"海鲜商城商品"
    }
  },
  mounted() {
    this.getShopCar();
    this.getMyAddress();
  },
  methods: {
    getShopCar() {
      user.getShopCar(window.localStorage.getItem("userId")).then(res => {
        this.shopcarList = res.data.data
      }).catch(err => {
        console.log(err)
      })
    },
    handleSelectionChange(list) {
      this.multipleSelection = list;
      let price = 0;
      for (let i = 0; i < list.length; i++) {
        price += list[i].seafood.outPrice * list[i].count;
      }
      this.allPrice = price;
    },
    deleteGoodFromCar(scope) {
      this.$confirm('此操作将 '+scope.row.seafood.name+'移除购物车, 是否继续?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        user.deleteShopCar(window.localStorage.getItem("userId"),scope.row.seafood.id).then(res=>{
          this.$message.success(res.data.message);
          this.getShopCar();
        }).catch(err=>{
          console.log(err)
        })
      }).catch(() => {
        this.$message({
          type: 'info',
          message: '已取消删除'
        });
      });
    },
    countChange() {
      this.handleSelectionChange(this.multipleSelection);
    },
    toPay(){
      if (this.addr == "" || this.addr.length == 0){
        this.$message.warning("请添加收货地址");
        return ;
      }

      let countObject = {flag : true,name :""};

      let list = [];
      for (let i = 0; i < this.multipleSelection.length; i++) {
        list.push(this.multipleSelection[i].seafoodId+"-"+this.multipleSelection[i].count)
      }

      //判断库存
      good.getSeafoodCountByList(list).then(res=>{
        if (res.data.code == 200){
          order.pay2(this.orderName,this.orderInfo,window.localStorage.getItem("userId"),list,
            this.addr,this.allPrice * 0.8).then((res=>{
            document.querySelector('body').innerHTML = res.data;//查找到当前页面的body，将后台返回的form替换掉他的内容
            document.forms[0].submit();  //执行submit表单提交，让页面重定向，跳转到支付宝页面
          }))
        }else if(res.data.code == 444){
          this.$message.warning(res.data.message);
        }
      })




      /*order.addOrder2(window.localStorage.getItem("userId"), list, this.addr, this.allPrice).then(res=>{
        this.$message.success(res.data.message);
        for (let i = 0; i < this.multipleSelection.length; i++) {
          user.deleteShopCar(window.localStorage.getItem("userId"),this.multipleSelection[i].seafoodId).then(res=>{
            this.getShopCar();
          }).catch(err=>{
            console.log(err)
          })
        }
      }).catch(err=>{

      })*/
    },
    getMyAddress() {
      user.getAllAdress(window.localStorage.getItem("userId")).then(res => {
        this.addrList = res.data.data
      })
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
