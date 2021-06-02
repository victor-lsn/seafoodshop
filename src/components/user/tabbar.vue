<template>
  <div class="header">
    <div style="display: flex;justify-content: space-between;width: 100%">
      <div>
        <span class="title" @click="toHome">海鲜商城</span>
      </div>
      <div>
        <el-button-group>
          <el-button v-if="userRole!=0" style="margin: 0 6px;font-size: 14px;color: black" type="text" class="btn-font" @click="toAdmin">后台管理</el-button>
          <el-button style="margin: 0 6px;font-size: 14px;color: black" type="text" class="btn-font" @click="toShopCar">批发车</el-button>
          <el-button style="margin: 0 6px;font-size: 14px;color: black" type="text" class="btn-font" @click="toOrder">我的订单</el-button>
          <el-button style="margin: 0 6px;font-size: 14px;color: black" type="text" class="btn-font" @click="toChat">客服</el-button>
          <el-button style="margin: 0 6px;font-size: 14px;color: black" type="text" v-if="username==null" class="btn-font" @click="toLogin">登录</el-button>
        </el-button-group>
        <el-popover v-if="username!=null" placement="bottom"
                    width="40"
                    trigger="hover">
          <div style="display: flex;">
            <el-button size="mini" type="text" @click="toAddress">管理地址</el-button>
            <el-button size="mini" type="text" @click="logout">退出登录</el-button>
          </div>
          <el-button type="text" style="font-size: 20px" size="mini" slot="reference">{{ username }}</el-button>
        </el-popover>
      </div>
    </div>
    <div style="display: flex;align-items: center;width: 100%;justify-content: center" @click="goSearch">
      <el-input style="width: 30%;border: 2px solid salmon;border-radius: 0" v-model="keywords" >
        <el-button slot="append" style="color:#ffffff;border: 3px salmon;border-radius: 0;background-color:salmon;" @click="goSearch">搜索</el-button>
      </el-input>
    </div>
  </div>
</template>

<script>
export default {
  name: "tabbar",
  props:{
    "categoryId":String,
    "paixu":String,
    "search":Object,
  },
  data() {
    return {
      username: localStorage.getItem("username"),
      userRole: localStorage.getItem("userRole"),
      keywords:""
    };
  },
  methods: {
    logout() {
      this.$router.go(0);
      localStorage.clear();
    },
    toLogin(){
      this.$router.push("/login");
    },
    toAdmin(){
      this.$router.push("/admin/home");
    },
    goSearch(){
      var path = this.$route.path;
      if (path!="/search"){
        this.$router.push("/search");
      }else {
        this.$parent.getSearchGoods(this.keywords,this.search.paixu,this.search.categoryId);
      }

    },
    toShopCar(){
      this.$router.push("/shopcar")
    },
    toAddress(){
      this.$router.push("/address")
    },
    toChat(){
      this.$router.push("/chat")
    },
    toOrder(){
      this.$router.push("/order")
    },
    toHome(){
      this.$router.push("/")
    }
  }
}
</script>

<style scoped>
.header {
  width: 100%;
  height: 80px;
  background-color: antiquewhite;
  display: flex;
  flex-direction: column;
  padding: 0 15px 10px 15px;
}

.title {
  font-size: 25px;
  font-weight: bold;
  cursor: pointer;
}


.el-popover {
  width: 80px;
}

.el-popover{
  z-index: 1000;
}
</style>
