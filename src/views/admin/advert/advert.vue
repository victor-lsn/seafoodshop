<template>
  <div>
    <el-breadcrumb separator="/">
      <el-breadcrumb-item>当前位置:</el-breadcrumb-item>
      <el-breadcrumb-item>媒体管理</el-breadcrumb-item>
      <el-breadcrumb-item>广告管理</el-breadcrumb-item>
    </el-breadcrumb>
      <el-card style="margin-top: 15px;">
        <div slot="header" class="clearfix" style="font-size: 20px;font-weight: bold">
          <span>轮播图区域</span>
        </div>
        <div v-for="item in advertList1" :key="item.id" style="width: 250px;height: 250px;margin: 0 10px 0 0px;display: flex;flex-direction: column;align-items: center">
          <img :src="baseUrl + item.name" style="width: 250px;height: 150px"/>
          <el-upload class="upload-demo" action="http://localhost:9527/admin/uploadLunbo" :headers="headers" :data="{id:item.id}" :on-success="successUpload1">
            <el-button style="margin: 10px 0 0 0" type="danger" circle class="el-icon-s-tools"></el-button>
          </el-upload>
        </div>
      </el-card>

      <el-card style="margin-top: 15px">
        <div slot="header" class="clearfix" style="font-size: 20px;font-weight: bold;margin-top:15px">
          <span>小图区域</span>
        </div>
        <div v-for="item in advertList2" :key="item.id" style="margin: 0 10px 0 0px;display: flex;flex-direction: column;align-items: center">
          <img :src="baseUrl + item.name" style="object-fit: cover;width: 150px;height: 100%"/>
          <el-upload class="upload-demo" action="http://localhost:9527/admin/uploadLunbo" :headers="headers" :data="{id:item.id}" :on-success="successUpload2">
            <el-button style="margin: 10px 0 0 0" type="warning" circle class="el-icon-s-tools"></el-button>
          </el-upload>
        </div>
      </el-card>

  </div>
</template>

<script>
import * as advert from "../../../network/admin/advert/advert"

export default {
  name: "advert",
  data() {
    return {
      advertList1: [],
      advertList2: [],
      baseUrl:advert.pic_url,
      headers:{
        "Authorization":window.localStorage.getItem("token")
      }
    }
  },
  mounted() {
    this.getAdverts();
  },
  methods: {
    getAdverts() {
      advert.getAllAdvert().then(res => {
        this.advertList1 = res.data.data.slice(0,4)
        this.advertList2 = res.data.data.slice(4,7)
      })
    },
    successUpload1(){
      this.$notify.success("修改轮播区域成功");
      this.getAdverts();
    },
    successUpload2(){
      this.$notify.success("修改小图区域成功");
      this.getAdverts();
    }
  }
}
</script>

<style scoped>
/deep/ .el-card__body{
  display: flex;
}

/depp/ .el-upload-list__item,.is-success{
  display: none;
}
</style>
