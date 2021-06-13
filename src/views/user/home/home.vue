<template>
  <div class="container">
    <div class="myheader">
      <home-tab-bar></home-tab-bar>
    </div>
    <!--  广告  -->
    <div class="wrapper" >
      <div class="bar" ref="barparent">
        <ul class="bartext" ref="barchild" :style="yellowBarTextStyle">
          <li v-for="(item, index) in newsList" :key="index" style="margin-right: 15px">{{ index + 1 }}.{{item.content}}</li>
        </ul>
      </div>
    </div>
    <div style="width: 100%;height: 100%;background-color: #F4F4F4">
      <!--  广告区域    -->
      <div style="display: flex;justify-content: center;align-items: center;width: 100%;height: 420px;margin-top: 15px">
        <!--    分类    -->
        <el-card style="width: auto;height: 100%;margin-right: 6px;box-shadow: none">
          <div slot="header" class="my_card_header">
            <span style="font-size: 15px;color: salmon;font-weight: 600">分类</span>
            <div style="height: 400px;margin-top: 15px">
<!--              <div v-for="(item,index) in newsList" :key="index" style="margin: 0 0 14px 0;font-size: 12px;color: #999999;display: flex;width: 100%;height: 33px;overflow: hidden;">
                <el-tooltip :content="item.content" placement="right" effect="light" style="">
                  <div style="display: flex;flex: 2;flex-wrap: wrap;direction: inherit">{{item.content}}</div>
                </el-tooltip>
              </div>-->
              <div v-for="(item,index) in allCategoryList" :key="index" style="margin: 0 0 14px 0;font-size: 12px;color: #999999;display: flex;width: 100%;height: 40px;">
                <el-tooltip placement="right" popper-class="testtooltip">
                  <div slot="content" style="display: flex">
                    <div v-for="(item2,index2) in item.children">
                      <el-button @click="categoryToSearch(item2.id)" type="text" style="color: black;">{{item2.name + "   /   "}}</el-button>
                    </div>
                  </div>
                  <el-button type="text" @click="categoryToSearch(item.id)" style="color: #475669" icon="el-icon-food">{{item.name}}</el-button>
                </el-tooltip>
              </div>
            </div>
          </div>
        </el-card>
        <!--    轮播图    -->
        <el-carousel :interval="5000" arrow="always" style="width: 46%;height: 100%">
          <el-carousel-item v-for="(item,index) in advertList" :key="index">
            <img :src="baseUrl+item.name" style="width: 100%;height:100%;object-fit: cover"/>
          </el-carousel-item>
        </el-carousel>
        <!--    展示    -->
        <div
          style="display: flex;flex-direction: column;width: 100px;justify-content: space-between;height: 100%;margin-left: 6px">
          <div style="width: 150px;height: 32%;background-color: antiquewhite" v-for="(item,index) in advertList2" :key="index">
            <img style="width: 150px;height: 100%" :src="baseUrl+item.name">
            <span style="position: relative;top: -80px;color: #F4F4F4;font-size: 60px;font-family: Helvetica;overflow: hidden">{{myNameList[index]}}</span>
          </div>
        </div>
      </div>
      <!--   主体部分   -->
      <div style="display: flex;flex-direction: column;justify-content: center;align-items: center">
        <!--   畅销商品   -->
        <div class="content_body_box">
          <div class="body_title">
            <img src="//misc.360buyimg.com/mtd/pc/index_2019/1.0.0/assets/sprite/floor_hd/sprite.png" height="20px"
                 width="30px" style="margin-right: 10px">
            <h2 style="font-size: 40px;font-weight: bold;margin: 10px 0 15px 0">畅销商品</h2>
            <img src="//misc.360buyimg.com/mtd/pc/index_2019/1.0.0/assets/sprite/floor_hd/sprite.png" height="20px"
                 width="30px" style="margin-left: 10px">
          </div>
          <div class="content_body">
            <div class="good_body" v-for="(item,index) in fireGoodList" @click="toGoodInfo(item.id)">
              <img :src="baseUrl+item.pics[0].name" style="width: 100%;height: 220px;object-fit: cover"/>
              <div class="my_price" style="color: #666666;min-height:64px;">{{item.name.length>32 ? item.name.substring(0,32)+"...":item.name}}</div>
              <div class="my_price">
                <span style="font-size: 13px;color: #666666;">销量：</span>
                <span style="font-size: 19px">{{item.saleCount}}</span>
              </div>
              <div class="my_price">
                <spa style="font-size: 13px;color: #666666;">售价：</spa>
                <span style="font-size: 19px;color: #D81E06">{{item.outPrice}}￥</span>
              </div>
<!--              <img class="yuanxingbiaozhi" src="../../../assets/fire.png">-->
            </div>
          </div>
        </div>
        <!--   热门分类   -->
        <div class="content_body_box">
          <div class="body_title">
            <img src="//misc.360buyimg.com/mtd/pc/index_2019/1.0.0/assets/sprite/floor_hd/sprite.png" height="20px"
                 width="30px" style="margin-right: 10px">
            <h3 style="font-size: 40px;font-weight: bold;margin: 10px 0 15px 0">热门分类</h3>
            <img src="//misc.360buyimg.com/mtd/pc/index_2019/1.0.0/assets/sprite/floor_hd/sprite.png" height="20px"
                 width="30px" style="margin-left: 10px">
          </div>
          <div class="content_body">
            <div class="good_body2" v-for="(item, index) in categoryList" :key="index">
              <img :src="baseUrl+item.pic" @click="categoryToSearch(item.id)" style="object-fit: cover;width: 100%;height: 300px">
              <div class="sanjiaobiaozhi">
                <span
                  style="display: block;transform: rotate(-43deg);position: relative;right: 20px;font-size: 20px;color: white">{{ item.name }}</span>
              </div>

            </div>
          </div>
        </div>
      </div>
      <div class="mybottom">
        <el-divider></el-divider>
        <div class="content_body_box">
          <!--    海惠派新    -->
          <div style="display: flex;justify-content: space-between;width: 100%">
            <div style="display: flex;justify-content: center;align-items: center">
              <img class="img_bottom" src="../../../assets/hai.png"/>
              <div class="font_bottom">真海捕捞</div>
            </div>
            <div style="display: flex;justify-content: center;align-items: center">
              <img class="img_bottom" src="../../../assets/hui.png"/>
              <div class="font_bottom">价格实惠</div>
            </div>
            <div style="display: flex;justify-content: center;align-items: center">
              <img class="img_bottom" src="../../../assets/pai.png"/>
              <div class="font_bottom">线下派送</div>
            </div>
            <div style="display: flex;justify-content: center;align-items: center">
              <img class="img_bottom" src="../../../assets/xin.png"/>
              <div class="font_bottom">绝对新鲜</div>
            </div>
          </div>
          <!--     友情链接等     -->
          <div style="display: flex;justify-content: space-between;width: 100%;margin-top: 15px;align-items: center">
            <div>
              <div class="bottome_font">关于我们 | 联系我们 | 合作招商 | 商家帮助 | 营销中心 | 友情链接 | 销售联盟 | 海鲜社区</div>
              <div class="bottome_font">风险检测 | 隐私政策 | 海鲜公益 | English Site | Media & IR</div>
              <div class="bottome_font">京公网安备 11000002000088号 | 京ICP备11041704号 | 互联网药品信息服务资格证编号(京)-经营性-2014-0008</div>
              <div class="bottome_font">互联网出版许可证编号新出网证(京)字150号 | 新出发京零 字第大120007号 | 出版物经营许可证</div>
              <div class="bottome_font">违法和不良信息举报电话：4006561155 | 消费者维权热线：4006067733 | 经营证照 | (京)网械平台备字(2018)第00003号
              </div>
              <div class="bottome_font">营业执照 | Global Site | Сайт России | Situs Indonesia | Sitio de España |
                เว็บไซต์ประเทศไทย
              </div>
            </div>
            <el-card style="width: 190px;height: 190px;display: flex;justify-content: center;align-items: center">
              <img class="img_bottom" src="../../../assets/me.jpg" style="height: 180px;width: 180px"/>
            </el-card>
          </div>
          <div style="display: flex;justify-content: center;width: 100%;margin-top: 20px;align-items: center">
            <img class="img_bottom" src="../../../assets/police.png" style="width:700px;object-fit: cover"/>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import tabbar from "@/components/user/tabbar";
import * as advert from "../../../network/admin/advert/advert"
import * as category from "../../../network/admin/category/category"
import * as good from "../../../network/admin/good/goods"
import * as news from "../../../network/admin/news/news"

export default {
  name: "home",
  components: {
    "home-tab-bar": tabbar
  },
  data() {
    return {
      advertList: [],
      advertList2: [],
      baseUrl: '',
      categoryList: [],
      allCategoryList:[],
      fireGoodList: [
        {
          pics:[
            {
              name:''
            }
          ]
        }
      ],
      myNameList:['Delicious','Fresh','Attact'],
      newsList:[],
      yellowBarTextStyle: {
        paddingLeft: '100px'
      }
    }
  },
  mounted() {
    this.getAllAdvert();
    this.getCategory();
    this.getFireGood();
    this.getNews();
    this.getAllCategory();
    this.timer = setInterval(this.move, 1000);
  },
  beforeDestroy() {
    clearInterval(this.timer);
  },
  methods: {
    move(){
      this.newsList.forEach((item,index)=>{
        //动态赋值动画区域的左padding 防止卡顿
        //console.log(item);
        //console.log(this.$refs.barparent)
        //const parentClientWidth = this.$refs.barparent[index].clientWidth;
        const parentClientWidth = this.$refs.barparent.clientWidth;
        //console.log(parentClientWidth)
        this.yellowBarTextStyle.paddingLeft = parentClientWidth + 'px';
        //判断动画区域是否超出父元素宽度 宽则有动画，不宽则无
        const parent = this.$refs.barparent;
        const child = this.$refs.barchild;
        //console.log("对比",child.clientWidth,parent.clientWidth)
        if(child.clientWidth > parent.clientWidth){
          child.classList.add('state-text-overflow');
        }else{
          child.classList.remove('state-text-overflow');
        }
      })
    },
    getAllAdvert() {
      advert.getAllAdvert().then(res => {
        this.baseUrl = advert.pic_url;
        if (res.data.code == 200) {
          this.advertList = res.data.data.slice(0, 4)
          this.advertList2 = res.data.data.slice(4, 7)
        }
      }).catch(err => {
        console.log(err)
      })
    },
    getAllCategory(){
      category.getAllCategory().then(res=>{
        this.allCategoryList = res.data.data;
      })
    },
    getCategory() {
      category.getParentCategoryVo().then(res => {
        if (res.data.code == 200) {
          this.categoryList = res.data.data.slice(0,5);
        }
      }).catch(err => {
        console.log(err)
      })
    },
    getFireGood() {
      good.getFireGood().then(res => {
        if (res.data.code == 200) {
          this.fireGoodList = res.data.data
        }
      }).catch(err => {
        console.log(err)
      })
    },
    toGoodInfo(id){
      this.$router.push({path:"/goodInfo",query:{goodId:id}})
    },
    getNews(){
      news.getAllNews(null,null,1,8).then(res=>{
        this.newsList = res.data.data.list.slice(0,8);
      });
    },
    categoryToSearch(id){
      this.$router.push({path:"/search",query:{categoryId:id}});
    }
  },
}
</script>

<style scoped>
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
}

.el-carousel__item h3 {
  color: #475669;
  font-size: 18px;
  opacity: 0.75;
  line-height: 300px;
  margin: 0;
}

.el-carousel__item:nth-child(2n) {
  background-color: #99a9bf;
}

.el-carousel__item:nth-child(2n+1) {
  background-color: #d3dce6;
}

.el-carousel__item {
  height: 420px !important;
}

.el-card__header {
  padding: 0;
}

.content_body_box {
  width: 75%;
  display: flex;
  align-items: center;
  flex-direction: column;
  justify-content: center
}

.body_title {
  display: flex;
  width: 100%;
  text-align: center;
  overflow: hidden;
  justify-content: center;
  align-items: center;
  font-size: 30px;
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

.good_body2 {
  width: 19%;
  height: 300px;
  background-color: #ffffff;
  margin: 3px;
}

.mybottom {
  width: 100%;
  height: 400px;
  display: flex;
  align-items: center;
  flex-direction: column;
}

.img_bottom {
  width: 42px;
  height: 42px;
  margin-right: 5px;
}

.font_bottom {
  font-size: 22px;
  font-weight: 200;
  color: #D81E06;
  font-family: 华文琥珀
}

.bottome_font {
  font-size: 14px;
  margin: 10px 0;
  color: #999999;
}

.el-card {
  background-color: #FAEBD7;
}

.sanjiaobiaozhi {
  width: 0;
  height: 0;
  border: 50px solid #D81E06;
  border-right: 50px solid transparent;
  border-top: 50px solid transparent;
  position: relative;
  bottom: 104px;
}

.yuanxingbiaozhi{
  width: 40px;
  height: 40px;
  display: flex;
  justify-content: center;
  align-items: center;
  position: relative;
  top: -300px;
  left: 6px;
  color: yellow;
}

.my_price{
  display: flex;
  width: 100%;
  font-size: 16px;
  justify-content: flex-start;
  align-items: center;
}

.wrapper {
  padding: 0 15px;
  display: flex;
  align-items: center;
  justify-content: center;
// background-color: "#FFF6EC";
}
.bar {
  width: 100%;
  height: 30px;
  line-height: 30px;
  overflow: hidden;
  box-sizing: border-box;
  display: flex;
  align-items: center;
  justify-content: center;
}
.bartext{
  white-space: nowrap;
  display: inline-block;
}
.bartext li{
  white-space: nowrap;
  display: inline-block;
  color: red;
  font-size: 14px;
}
.state-text-overflow{
  animation: move_left_right 40s linear 0s infinite ;
}
@keyframes move_left_right {
  from{
    transform: translateX(0%);
  }
  to{
    transform: translateX(-40%);
  }
}

/deep/ .testtooltip{
  background: white !important;
  box-shadow: 1px 1px 10px 3px #D3D3D6;
}
</style>

<style>
.testtooltip{
  background: #FAEBD7 !important;
  color: black !important;
}

.el-tooltip__popper[x-placement^="bottom"] .popper__arrow {
  border-bottom-color: #FAEBD7 !important;
}

.el-tooltip__popper[x-placement^="bottom"] .popper__arrow:after {
  border-bottom-color: #FAEBD7 !important;
}
</style>
