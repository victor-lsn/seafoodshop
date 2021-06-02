<template>
  <div class="container">
    <div class="myheader">
      <home-tab-bar></home-tab-bar>
    </div>
    <div style="width: 100%;height: 100%;background-color: #F4F4F4;">
      <div style="display: flex;flex-direction: column;justify-content: center;align-items: center;margin-top: 15px">
        <!--    商品参数信息    -->
        <div style="display: flex;flex-direction: column;width: 100%;align-items: center;">
          <div style="display: flex;align-items: center;width: 60%;">
            <div style="width: 5px;background-color:#ED9730;height: 40px;"></div>
            <div class="module-title">商品参数</div>
          </div>
        </div>
        <div style="width: 60%;display: flex;justify-content: space-between">
          <el-carousel :interval="5000" arrow="always" style="width: 50%;height: 100%">
            <el-carousel-item v-for="(item,index) in goodInfo.pics" :key="index">
              <img :src="baseUrl+item.name" style="width: 100%;height:100%;object-fit: cover"/>
            </el-carousel-item>
          </el-carousel>
          <div style="display: flex;width: 49%;flex-direction: column;justify-content: space-between">
            <div class="good-title">{{ goodInfo.name }}</div>
            <div>
              <div style="display: flex;color: red;font-size: 10px;margin: 5px 0px">
                <div>逢年过节硬菜！</div>
                <div>鲜香爽滑！</div>
                <div>送礼佳品！</div>
                <div>品质保障！</div>
              </div>
              <!--     售价       -->
              <div style="background-color:#ffffff;display: flex;padding: 5px 10px;justify-content: space-between">
                <div style="display: flex;flex-direction: column">
                  <div style="display: flex;align-items: center;margin-right: 3px;justify-content: space-between">
                    <div style="display: flex;align-items: center;justify-content: flex-start">
                      <div style="font-size: 14px;color: #999999">售价</div>
                      <div style="display: flex;align-items: center">
                        <div style="font-size: 14px;color: red">￥</div>
                        <div style="font-size: 19px;color: red">{{ goodInfo.outPrice }}</div>
                      </div>
                    </div>
                  </div>
                  <div style="display: flex;align-items: center">
                    <div style="font-size: 14px;color: #999999;margin-right: 3px">促销</div>
                    <div style="border: 1px solid red;color: red;padding: 0px 1px;font-size: 14px">折扣</div>
                    <div style="font-size: 19px;color: red">{{ goodInfo.discount }}</div>
                  </div>
                  <div style="display: flex;align-items: center">
                    <div style="font-size: 14px;color: #999999;margin-right: 3px">规格</div>
                    <div style="font-size: 14px;color: red">{{goodInfo.weight}} kg</div>
                  </div>
                  <div style="display: flex;align-items: center">
                    <div style="font-size: 14px;color: #999999;margin-right: 3px">产地</div>
                    <div style="font-size: 14px;color: red">{{goodInfo.seafoodSource}}</div>
                  </div>
                </div>
                <div style="display: flex;align-items: center">
                  <div style="width: 3px;background-color:#999999;height: 80px;margin-right: 16px"></div>
                  <div style="display: flex;flex-direction: column">
                    <div style="font-size: 11px;color: #999999">累计销量</div>
                    <div style="color: #4E5EAE">{{ goodInfo.saleCount }}</div>
                    <div style="font-size: 11px;color: #999999;margin-top: 4px">库存</div>
                    <div style="color: #4E5EAE">{{ goodInfo.count }}</div>
                  </div>
                </div>
              </div>
              <!--     用户地址       -->
              <div style="display: flex;align-items: center;justify-content: space-between;margin: 5px 0">
                <div style="display: flex;align-items: center">
                  <div style="font-size: 14px;color: #999999;margin-right: 7px">收货地址</div>
                  <el-select v-model="addr" placeholder="选择收货地址">
                    <el-option v-for="item in addrList"
                               :key="item.id"
                               :label="item.addr"
                               :value="item.id"></el-option>
                  </el-select>
                </div>
                <el-button type="text" @click="toAddress">添加收货地址</el-button>
              </div>
              <div style="display: flex;justify-content: space-between">
                <div>
                  <el-button type="warning" style="background-color:#ED9730;border-radius: 0;font-weight: bold"
                             @click="addToShopCar">加入批发车
                  </el-button>
                  <el-button type="danger" style="background-color:#DF3033;border-radius: 0;font-weight: bold"
                             @click="toPay">立即购买
                  </el-button>
                </div>
                <el-tooltip class="item" effect="light" content="人工客服" placement="bottom">
                  <el-button circle class="el-icon-phone-outline" @click="toChat"
                             style="background-color:#D81E06;color: white;font-size: 16px"></el-button>
                </el-tooltip>
              </div>
              <div style="display: flex;">
                <div style="font-size: 12px;color: #999999;margin-right: 3px">温馨提示</div>
                <div style="font-size: 12px;color: #999999;margin-right: 3px">~不支持7天无理由退货</div>
              </div>
            </div>
          </div>
        </div>
        <!--    详情    -->
        <div style="width: 60%;display: flex;flex-direction: column;margin: 20px 0">
          <div style="display: flex;align-items: center;width: 100%">
            <div style="width: 5px;background-color:#ED9730;height: 40px;"></div>
            <div class="module-title">商品详情</div>
          </div>
          <div>
            <div style="display: flex;align-items: center">
              <div style="font-size: 20px;color: #D81E06;font-weight: bold">描述</div>
            </div>
            <div>{{ goodInfo.info }}</div>
          </div>
          <div>
            <div style="display: flex;align-items: center">
              <div style="font-size: 20px;color: #D81E06;font-weight: bold">相关图片</div>
            </div>
            <div v-for="(item,index) in goodInfo.pics" style="border: 25px solid #ffffff" :key="index">
              <img :src="baseUrl+item.name" style="width: 100%;height:100%;object-fit: cover"/>
            </div>
          </div>
        </div>

        <!--    评论    -->
        <div style="width: 60%;display: flex;flex-direction: column;">
          <div style="display: flex;align-items: center;width: 100%">
            <div style="width: 5px;background-color:#ED9730;height: 40px;"></div>
            <div class="module-title">商品评论</div>
          </div>
          <div>
            <el-input v-model="commentMessage" type="textarea" placeholder="请输入评论内容"
                      :autosize="{minRows: 5, maxRows: 6}"></el-input>
            <el-button circle class="el-icon-s-promotion" @click="publish"
                       style="background-color:blue;color: white;position: relative;top: -50px;left: 10px"></el-button>
          </div>
          <el-tree :data="commentList" default-expand-all style="position: relative;top: -40px">
            <span style="width: 100%;padding: 0 15px 0 0" class="custom-tree-node" slot-scope="{ node, data }">
              <div v-if="data.level == 1"
                   style="display: flex;align-items: center;justify-content: space-between;width: 100%">
                <div style="display: flex;flex-direction: column">
                  <div style="display: flex">
                    <div>{{ data.fromUserName }}</div>
                    <div style="margin-left: 15px">{{ data.date.substring(0, 19).replace("T", " ") }}</div>
                  </div>
                  <div>{{ data.content }}</div>
                </div>
                <el-button type="text" size="mini" @click="() => publish2(data)">回复</el-button>
              </div>
              <div v-if="data.level == 2"
                   style="display: flex;align-items: center;justify-content: space-between;width: 100%">
                <div style="display: flex;flex-direction: column">
                 <div style="display: flex">
                    <div>{{ data.fromUserName }} 回复 {{ data.toUserName }}</div>
                    <div style="margin-left: 15px">{{ data.date.substring(0, 19).replace("T", " ") }}</div>
                 </div>
                  <div>{{ data.content }}</div>
                </div>
                <el-button type="text" size="mini" @click="() => publish2(data)">回复</el-button>
              </div>
            </span>
          </el-tree>
        </div>
      </div>
      <my-bottom></my-bottom>

      <!--   发表子集评论   -->
      <el-dialog
        :title="'评论：'+currentMessageData.fromUserName"
        :visible.sync="commentDialog"
        width="30%">
        <el-input v-model="commentMessage2"></el-input>
        <span slot="footer" class="dialog-footer">
          <el-button type="primary" @click="sendPublish">确 定</el-button>
        </span>
      </el-dialog>
    </div>
  </div>
</template>

<script>
import tabbar from "../../../components/user/tabbar";
import mybottom from "../../../components/user/mybottom";
import * as good from "../../../network/admin/good/goods"
import * as user from "../../../network/admin/user/user"
import * as order from "../../../network/admin/order/order"

export default {
  name: "goodInfo",
  components: {
    "home-tab-bar": tabbar,
    "my-bottom": mybottom
  },
  data() {
    return {
      goodInfo: {
        pics: []
      },
      baseUrl: good.pic_url,
      drawer: false,
      websock: null,
      messageInput: "",
      messageList: [],
      addrList: [],
      addr: "",
      commentMessage: "",
      commentList: [],
      commentDialog: false,
      currentMessageData: {},
      commentMessage2: ""
    }
  },
  mounted() {
    this.getGoodInfo();
    this.getMyAddress();
    this.getComment();
  },
  methods: {
    getGoodInfo() {
      good.getSeafoodById(this.$route.query.goodId).then(res => {
        this.goodInfo = res.data.data
      }).catch(err => {
        console.log(err);
      })
    },
    toAddress() {
      this.$router.push("/address")
    },
    addToShopCar() {
      user.addShopCar(window.localStorage.getItem("userId"), this.goodInfo.id).then(res => {
        if (res.data.code == 200) {
          this.$message.success(res.data.message)
        } else if (res.data.code == 444) {
          this.$message.warning(res.data.message)
        }
      }).catch(err => {
        console.log(err)
      })
    },
    getMyAddress() {
      user.getAllAdress(window.localStorage.getItem("userId")).then(res => {
        this.addrList = res.data.data
      })
    },
    toPay() {
      if (this.addr.length == 0) {
        this.$message.warning("请先选择收货地址")
        return;
      }
      this.addOrder();
    },
    getComment() {
      user.getCommentList(this.$route.query.goodId).then(res => {
        this.commentList = res.data.data
      }).catch(err => {
        console.log(err);
      })
    },
    publish() {
      if (this.commentMessage.length > 0) {
        user.addComment(window.localStorage.getItem("userId"), null, this.goodInfo.id,
          null, 1, this.commentMessage, window.localStorage.getItem("username"), null).then(res => {
          this.$message.success(res.data.message);
          this.getComment();
          this.commentMessage = "";
        }).catch(err => {
          console.log(err);
        })
      } else {
        this.$message.warning("请填写评论内容");
        return;
      }
    },
    publish2(data) {
      this.commentDialog = true;
      this.currentMessageData = data;
    },
    sendPublish() {
      if (this.currentMessageData.parent == null) {
        this.currentMessageData.parent = this.currentMessageData.id;
      }
      if (this.commentMessage2.length > 0) {
        user.addComment(window.localStorage.getItem("userId"), this.currentMessageData.fromUserId, this.goodInfo.id,
          this.currentMessageData.parent, 2, this.commentMessage2, window.localStorage.getItem("username"), this.currentMessageData.fromUserName).then(res => {
          this.$message.success(res.data.message);
          this.getComment();
          this.commentMessage2 = "";
          this.commentDialog = false;
        }).catch(err => {
          console.log(err);
        })
      } else {
        this.$message.warning("请填写评论内容");
        return;
      }
    },
    toChat() {
      this.$router.push("/chat")
    },
    addOrder() {
      good.getSeafoodCount(this.goodInfo.id).then(res =>{
        if (res.data.data > 0){
          order.pay(this.goodInfo.name, this.goodInfo.name,window.localStorage.getItem("userId"), this.goodInfo.id, this.addr,).then(res => {
            document.querySelector('body').innerHTML = res.data;//查找到当前页面的body，将后台返回的form替换掉他的内容
            document.forms[0].submit();  //执行submit表单提交，让页面重定向，跳转到支付宝页面
          })
        }else {
          this.$notify.warning("商品库存不足，正在补货中");
        }
      })

      /*order.addOrder1(window.localStorage.getItem("userId"), this.goodInfo.id, this.addr,
        this.goodInfo.outPrice, this.goodInfo.outPrice * this.goodInfo.discount).then(res => {
        this.$message.success(res.data.message);
      }).catch(err => {
        console.log(err);
      })*/
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
  width: 66%;
  display: flex;
  align-items: center;
  flex-direction: column;
  justify-content: center;
  margin-top: 20px;
}

.content_body {
  display: flex;
  justify-content: space-between;
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
}


.good-title {
  font-size: 20px;
  color: #666666;
}

.module-title {
  font-size: 25px;
  color: #ED9730;
  background-color: #fff;
  height: 40px;
  display: flex;
  align-items: center;
  padding: 0px 5px;
  width: 100%;
  font-weight: bold;
}


/deep/ .el-tree-node__content {
  height: 70px;
}

/deep/ .el-textarea__inner {
  border-radius: 0px;
  border: 0;
}
</style>
