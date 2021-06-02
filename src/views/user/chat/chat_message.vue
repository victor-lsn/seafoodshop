<template>
  <div style="width: 100%;height: 100%">
    <div style="height: 75%;width: 100%;background-color:goldenrod;">
      <div style="display: flex;align-items: center;justify-content: center;width: 100%;font-size: 20px">
        {{ '客服：' +waiter.name}}
        {{redata}}
      </div>
      <div v-for="message in messageList">
        <div class="messageMe" v-if="message.type == 'other'">
          <p
            style="display: flex;justify-content: flex-start;background-color:blue;padding: 5px 10px;border-radius: 3px;font-size: 15px">
            {{ message.message }}</p>
        </div>
        <div class="messageOther" v-if="message.type == 'me'">
          <p
            style="display: flex;justify-content: flex-end;background-color:darkred;padding: 5px 10px;border-radius: 3px;font-size: 15px">
            {{ message.message }}</p>
        </div>
      </div>
    </div>
    <div style="height: 25%;width: 100%">
      <el-input class="messageTextArea"
                type="textarea"
                :rows="5"
                placeholder="请输入内容"
                v-model="messageInput">
      </el-input>
      <el-button circle style="background-color:dodgerblue;color: white" class="el-icon-s-promotion messageButton"
                 @click="sendClientMessage"></el-button>
    </div>
  </div>
</template>

<script>
export default {
  name: "chat_message",
  props:{
    waiter:Object,
    required:true,
    redata:Object
  },
  data() {
    return {
      messageList:[],
      messageInput:"",
    }
  },
  mounted() {

  },
  methods:{
    sendClientMessage(){
      this.$emit('sendMessage',this.messageInput,this.waiter.id)
      this.messageList.push({
        type:'me',
        message:this.messageInput
      })
      this.messageInput = "";
    }
  }
}
</script>

<style scoped>
.messageMe {
  color: white;
  padding: 0 10px;
  display: flex;
  justify-content: flex-start;
  margin: 0 0 5px 0;
}
.messageButton{
  position: relative;
  bottom: 48px;
  left: 8px;
}
.messageOther {
  color: white;
  padding: 0 10px;
  display: flex;
  justify-content: flex-end;
  margin: 0 0 5px 0;
}
</style>
