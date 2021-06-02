<template>
  <div class="container">
    <div class="myheader">
      <tabbar></tabbar>
    </div>
    <div style="width: 100%;display: flex;justify-content: center;margin-top: 15px">
      <el-card style="width: 40%;position: absolute">
        <div slot="header" class="clearfix">
          <span style="font-size: 20px;color: white">聊天</span>
        </div>
        <div style="display: flex;flex-direction: row;justify-content: space-between">
          <!--    左边好友      -->
          <div style="width: 30%;height: 400px;display: flex;flex-direction: column">
            <el-button-group>
              <div :class="currentUser == item.userName ? gaoliang : wugaoliang" v-for="(item,index) in userList"
                   style="display: flex;align-items: center;justify-content: space-between;"
                   :key="index" @click="huanren(item)">
                <el-button type="text" style="color: black;font-size: 18px">{{ item.userName }}</el-button>
                <el-tag v-if="item.messageCount>0" type="danger"
                        style="border-radius: 50%;background-color:red;color: white;font-weight: bold;height: 30px;width: 30px">
                  {{ item.messageCount }}
                </el-tag>
              </div>
            </el-button-group>
          </div>
          <!--    聊天窗体      -->
          <div style="width: 74%;height: 400px">
            <div style="height: 75%;width: 100%;background-color:#ffef9f;overflow-y: auto;" ref="chatContent">
              <div v-if="currentUser.length == 0" style="width: 100%;display: flex;justify-content: center;height: 50px;align-items: center;">
                  <div>赶快选个人聊天吧</div>
              </div>
              <div v-for="message in messageList">
                <div class="messageMe" v-if="message.type == 'other' && message.fromUserName == currentUser">
                  <p
                    style="display: flex;justify-content: flex-start;background-color:#73bfb8;padding: 5px 10px;border-radius: 3px;font-size: 15px">
                    {{ message.message }}</p>
                </div>
                <div class="messageOther" v-if="message.type == 'me' && message.toUserName == currentUser">
                  <p
                    style="display: flex;justify-content: flex-end;background-color:#f15152;padding: 5px 10px;border-radius: 3px;font-size: 15px">
                    {{ message.message }}</p>
                </div>
                <!--                <div class="messageMe" v-if="message.type == 'other'">-->
                <!--                  <p-->
                <!--                    style="display: flex;justify-content: flex-start;background-color:blue;padding: 5px 10px;border-radius: 3px;font-size: 15px">-->
                <!--                    {{ message.message }}</p>-->
                <!--                </div>-->
                <!--                <div class="messageOther" v-if="message.type == 'me'">-->
                <!--                  <p-->
                <!--                    style="display: flex;justify-content: flex-end;background-color:darkred;padding: 5px 10px;border-radius: 3px;font-size: 15px">-->
                <!--                    {{ message.message }}</p>-->
                <!--                </div>-->
              </div>
            </div>
            <div style="height: 25%;width: 100%">
              <el-input class="messageTextArea"
                        type="textarea"
                        :rows="5"
                        placeholder="请输入内容"
                        v-model="messageInput">
              </el-input>
              <el-button circle style="background-color:#6b9ac4;color: white"
                         class="el-icon-s-promotion messageButton"
                         @click="sendClientMessage"></el-button>
            </div>
          </div>

        </div>
      </el-card>
    </div>

  </div>
</template>

<script>
import tabbar from "../../../components/user/tabbar";
import chat_message from "./chat_message";
import * as user from "../../../network/admin/user/user"

export default {
  components: {
    tabbar,
    chat_message
  },
  name: "chat",
  data() {
    return {
      messageInput: "",
      messageList: [],
      userList: [],
      currentUser: "",
      currentIndex: 0,
      gaoliang: "gaoliang",
      wugaoliang: "wugaoliang",
    }
  },
  mounted() {
    this.getAllWaiter();
  },
  created() {
    this.initWebSocket();
  },
  destroyed() {
    this.websock.close() //离开路由之后断开websocket连接
  },
  methods: {
    initWebSocket() { //初始化weosocket
      const wsuri = "ws://127.0.0.1:9003/messageServer/" + window.localStorage.getItem("userId") + "/" + window.localStorage.getItem("username");
      this.websock = new WebSocket(wsuri);
      this.websock.onmessage = this.websocketonmessage;
      this.websock.onopen = this.websocketonopen;
      this.websock.onerror = this.websocketonerror;
      this.websock.onclose = this.websocketclose;
    },
    websocketonopen() {
      console.log("建立连接")
    },
    websocketonerror() {//连接建立失败重连
      this.initWebSocket();
    },
    websocketonmessage(messageJSON) {
      console.log(messageJSON);
      //var data = '{"userList":[],"messageType":1}';
      //console.log(JSON.parse(data));
      console.log(JSON.parse(messageJSON.data))
      let data = JSON.parse(messageJSON.data);
      if (data.messageType == 1) {
        console.log("接收到用户列表信息")
        console.log("用户列表：" + data.userList)
        //this.userList = data.userList;
        for (let i = 0; i < data.userList.length; i++) {
          this.userList.push({
            userName: data.userList[i],
            messageCount: 0
          })
        }
      }
      if (data.messageType == 2) {
        console.log("普通消息")
        console.log("接收到：" + data.fromUserName + " 的信息")
        console.log("信息： " + data.message)
        this.messageList.push({
          type: "other",
          fromUserName: data.fromUserName,
          message: data.message
        })
        if (data.fromUserName != this.currentUser) {
          for (let i = 0; i < this.userList.length; i++) {
            if (this.userList[i].userName == data.fromUserName) {
              this.userList[i].messageCount = this.userList[i].messageCount + 1;
            }
          }
        }
        this.$nextTick(() => {
          this.$refs.chatContent.scrollTop = this.$refs.chatContent.scrollHeight;
        })
      }
      //{"userList":[],"messageType":1}
    },
    websocketsend(Data) {//数据发送
      this.websock.send(Data);
    },
    websocketclose(e) {  //关闭
      console.log('断开连接', e);
    },
    sendClientMessage(message, toUserId) {
      if (this.currentUser.length == 0) {
        this.$message.warning("请选择聊天对象")
        return;
      }
      if (this.messageInput.length > 0) {
        this.websocketsend(JSON.stringify({
          "toUserName": this.currentUser,
          "message": this.messageInput
        }));
      } else {
        this.$message.warning("请输入聊天内容")
        return;
      }
      this.messageList.push({
        type: "me",
        toUserName: this.currentUser,
        message: this.messageInput
      })
      this.messageInput = ""
      this.$nextTick(() =>{
        this.$refs.chatContent.scrollTop = this.$refs.chatContent.scrollHeight;
      })
    },
    getAllWaiter() {
      user.getAllWaiter().then(res => {
        this.waiterList = res.data.data
      }).catch(err => {
        console.log(err)
      })
    },
    huanren(user) {
      this.currentUser = user.userName;
      user.messageCount = 0
    }
  },

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


/deep/ .el-textarea__inner {
  border-radius: 0px;
}

.btn:active {
  background-color: #DF3033;
}

.gaoliang {
  background-color: #ffef9f;
  padding: 10px 3px 10px 13px;
  font-size: 15px;
  color: white;
}

.wugaoliang {
  background-color: #6b9ac4;
  padding: 10px 3px 10px 13px;
  font-size: 15px;
  color: white;
}

.messageMe {
  color: white;
  padding: 0 10px;
  display: flex;
  justify-content: flex-start;
  margin: 5px 0 0 0;
}

.messageButton {
  position: relative;
  bottom: 48px;
  left: 8px;
}

.messageOther {
  color: white;
  padding: 0 10px;
  display: flex;
  justify-content: flex-end;
  margin: 5px 0 0 0;
}

.el-card {
  background-color: #6b9ac4;
}
</style>
