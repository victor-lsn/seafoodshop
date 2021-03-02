<template>
  <div style="width: 100%;height: 100%">
    <el-container>
      <!--头部区域-->
      <el-header>
        <div style="display: flex;align-items: center;justify-content: space-between;height: 100%">
          <div style="display: flex;align-items: center">
            <img src="../../../assets/fish2.png" width="50px" height="50px"/>
            <div style="color: white;margin-left: 20px;font-size: 22px">海鲜商城后台管理系统</div>
          </div>
          <el-button type="text" style="font-size: 16px" @click="toFront">返回前台</el-button>
        </div>
      </el-header>
      <el-container>
        <!--左侧菜单区域-->
        <el-aside width="200px">
          <el-menu
            background-color="#333744"
            text-color="#fff"
            active-text-color="#ffd04b" v-for="item in menuList" :key="item.id" router unique-opened>
            <el-submenu :index="item.id+''">
              <!--一级菜单-->
              <template slot="title">
                <i :class="item.icon"></i>
                <span>{{ item.name }}</span>
              </template>
              <!--二级菜单-->
              <el-menu-item :index="sub.path" v-for="sub in item.children" :key="sub.id">
                <template slot="title">
                  <i :class="sub.icon"></i>
                  <span>{{ sub.name }}</span>
                </template>
              </el-menu-item>
            </el-submenu>
          </el-menu>
        </el-aside>
        <!--右侧主体区域-->
        <el-main>
          <router-view></router-view>
        </el-main>
      </el-container>
    </el-container>
  </div>
</template>

<script>
import * as menu from "../../../network/admin/menu/menu"

export default {
  name: "home",
  data() {
    return {
      menuList: []
    }
  },
  mounted() {
    this.getMenu();
  },
  methods: {
    getMenu() {
      menu.getMenu().then(res => {
        if (res.data.code == 200) {
          this.menuList = res.data.data;
        }
      }).catch(err => {
        //console.log(err);
      })
    },
    toFront(){
      this.$router.push("/")
    }
  }
}
</script>

<style scoped>

.el-container {
  height: 100%;
}

.el-header {
  background-color: #373d41;
  position: relative;
  width: 100%;
}

.el-menu {
  border: 0;
}

.el-aside {
  background-color: #333744;
  position: absolute;
  display: block;
  left: 0;
  top: 60px;
  bottom: 0;
}

.el-main {
  background-color: #eaedf1;
  position: absolute;
  left: 200px;
  right: 0;
  bottom: 0;
  top: 60px;
  overflow: scroll;
}
</style>
