<template>
  <div class="header">
    <div>
      <span class="title">海鲜商城</span>
    </div>
    <div>
      <el-button-group>
        <el-button v-if="userRole==1" style="margin: 0 6px;font-size: 14px;color: black" type="text" class="btn-font" @click="toAdmin">后台管理</el-button>
        <el-button style="margin: 0 6px;font-size: 14px;color: black" type="text" class="btn-font">购物车</el-button>
        <el-button style="margin: 0 6px;font-size: 14px;color: black" type="text" class="btn-font">账户</el-button>
        <el-button style="margin: 0 6px;font-size: 14px;color: black" type="text" v-if="username==null" class="btn-font" @click="toLogin">登录</el-button>
      </el-button-group>
      <el-popover v-if="username!=null"
                  width="40"
                  trigger="hover">
        <el-button  style="width: 100%" @click="logout">退出登录</el-button>
        <el-button type="text" style="font-size: 20px" size="mini" slot="reference">{{ username }}</el-button>
      </el-popover>
    </div>
  </div>
</template>

<script>
export default {
  name: "tabbar",
  data() {
    return {
      username: localStorage.getItem("username"),
      userRole: localStorage.getItem("userRole"),
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
    }
  }
}
</script>

<style scoped>
.header {
  width: 100%;
  height: 40px;
  background-color: antiquewhite;
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 0px 15px;
}

.title {
  font-size: 25px;
  font-weight: bold;
}


.el-popover {
  width: 80px;
}

</style>
