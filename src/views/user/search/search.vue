<template>
  <div class="container">
    <div class="myheader">
      <home-tab-bar ref="tabbar" :categoryId="categoryId" :paixu="paixu" :search='this'></home-tab-bar>
      <div style="width: 100%;height: 30px;background-color:#FAEBD7;"></div>
    </div>
    <div style="background-color:antiquewhite;position:fixed;top:70px;z-index: 100;padding: 0 0 0 20px;display: flex">
      <div @click="categoryFlag = !categoryFlag" style="cursor: pointer;display: flex;align-items: center">
        <i v-if="categoryFlag" class="el-icon-caret-bottom" style="margin-right: 3px"></i>
        <i v-if="!categoryFlag" class="el-icon-caret-right" style="margin-right: 3px"></i>
        <div style="color: #EB7E71">{{categoryName.length == 0 ? '请选择分类' : categoryName}}</div>
      </div>
      <div @click="changePaixu" style="cursor: pointer;display: flex;align-items: center;margin-left: 20px">
        <i v-if="paixu == 'DESC'" class="el-icon-bottom" style="margin-right: 3px"></i>
        <i v-if="paixu == 'ASC'" class="el-icon-top" style="margin-right: 3px"></i>
        <div style="color: #EB7E71">{{paixu == 'DESC' ? '价格降序' : '价格升序'}}</div>
      </div>
    </div>

    <div v-if="categoryFlag" style="padding: 20px 0 0 20px;background-color:antiquewhite;position: fixed;top: 90px;z-index: 99;left: 0;right: 0">
      <div v-for="(item,index) in allCategoryList" :key="index" style="display: flex">
        <el-radio @change="categoryChange"  v-model="categoryId"  :label="item.id+''" class="radioStyle">{{ item.name}}</el-radio>
        <div v-for="(item2,index2) in item.children" :key="index2">
          <el-radio @change="categoryChange" v-model="categoryId"  :label="item2.id+''" class="radioStyle">{{ item2.name }}</el-radio>
        </div>
      </div>
    </div>
    <div style="width: 100%;height: 100%;background-color: #F4F4F4">
      <div v-if="goodList.length == 0" style="display: flex;justify-content: center;align-items: center;margin-top: 40px">不存在这种商品哦，紧急补货中......</div>
      <div style="display: flex;flex-direction: column;justify-content: center;align-items: center">
        <div class="content_body_box">
          <div class="content_body">
            <div class="good_body" v-for="(item,index) in goodList" @click="toGoodInfo(item.id)">
              <img :src="baseUrl+item.pics[0].name" style="width: 100%;height: 220px;object-fit: cover"/>
              <div class="my_price" style="color: #666666;min-height:64px;">
                {{ item.name.length > 32 ? item.name.substring(0, 32) + "..." : item.name }}
              </div>
              <div class="my_price">
                <span style="font-size: 13px;color: #666666;">销量：</span>
                <span style="font-size: 19px">{{ item.saleCount }}</span>
              </div>
              <div class="my_price">
                <spa style="font-size: 13px;color: #666666;">售价：</spa>
                <span style="font-size: 19px;color: #D81E06">{{ item.outPrice }}￥</span>
              </div>
            </div>
          </div>
        </div>
      </div>
      <my-bottom></my-bottom>
    </div>
  </div>
</template>

<script>
import tabbar from "../../../components/user/tabbar";
import mybottom from "../../../components/user/mybottom";
import * as good from "../../../network/admin/good/goods"
import * as category from "../../../network/admin/category/category"

export default {
  name: "search",
  components: {
    "home-tab-bar": tabbar,
    "my-bottom": mybottom
  },
  beforeRouteEnter(to, from, next){
    next(vm =>{
      console.log(from) // 上一页面的路由信息
    })
  },
  data() {
    return {
      goodList: [
        {
          pics: [
            {
              name: ''
            }
          ]
        }
      ],
      baseUrl: good.pic_url,
      allCategoryList: [],
      categoryId:null,
      categoryFlag:false,
      categoryName:"",
      paixu:"DESC",
    }
  },
  mounted() {
    this.getAllCategory();
  },
  methods: {
    getSearchGoods(keywords,paixu,categoryId) {
      good.getSearchGoods(keywords,paixu,categoryId).then(res=>{
        this.goodList = res.data.data;
      })
    },
    getAllCategory() {
      category.getAllCategory().then(res => {
        this.allCategoryList = res.data.data;

        this.categoryId = this.$route.query.categoryId;

        this.getCategoryNameById(this.categoryId);

        this.getSearchGoods("",this.paixu,this.categoryId);
      })
    },
    toGoodInfo(id) {
      this.$router.push({path: "/goodInfo", query: {goodId: id}})
    },
    getCategoryNameById(id){
      for (let i = 0; i < this.allCategoryList.length; i++) {
        if (this.allCategoryList[i].id == id){
          this.categoryName = this.allCategoryList[i].name;
        }else {
          if (this.allCategoryList[i].children.length > 0){
            for (let j = 0; j < this.allCategoryList[i].children.length; j++) {
              if (this.allCategoryList[i].children[j].id == id){
                this.categoryName = this.allCategoryList[i].children[j].name;
              }
            }
          }
        }
      }
    },
    categoryChange(val){
      this.getCategoryNameById(val);
      this.categoryFlag = false;
    },
    changePaixu(){
      if (this.paixu == 'DESC'){
        this.paixu = 'ASC';
        this.$refs.tabbar.goSearch();
      }else {
        this.paixu = 'DESC';
        this.$refs.tabbar.goSearch();
      }
    }
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

.content_body_box {
  width: 75%;
  display: flex;
  align-items: center;
  flex-direction: column;
  justify-content: center;
  margin-top: 20px;
}

.content_body {
  display: flex;
  justify-content: flex-start;
  width: 100%;
  flex-wrap: wrap
}

.good_body {
  width: 19%;
  height: 320px;
  background-color: #ffffff;
  margin-bottom: 3px;
  display: flex;
  flex-direction: column;
  align-items: center;
  padding: 4px;
  margin: 1px;
}

.my_price {
  display: flex;
  width: 100%;
  font-size: 16px;
  justify-content: flex-start;
  align-items: center;
}

.radioStyle {
  width: 90px;
  height: 20px;
}


</style>

<style>
.el-radio__input.is-checked .el-radio__label {
  color: salmon !important;
  border-color: salmon !important;
}

.el-radio__input.is-checked .el-radio__inner {
  background: salmon !important;
  border-color: salmon !important;
}
</style>
