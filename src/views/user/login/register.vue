<template>
  <div class="login-box">
    <div class="background_image">
      <img src="../../../assets/back1.png" height="100%" width="100%"/>
    </div>
    <div style="padding: 40px">
      <el-card class="login-body">
        <el-form :model="ruleForm" :rules="rules" ref="ruleForm" label-width="100px" class="demo-ruleForm">
          <el-form-item style="display: flex;width: 100%;justify-content: center;align-items: center">
            <span style="font-size: 25px;font-weight: bold">海鲜商城</span>
          </el-form-item>
          <el-form-item label="用户名" prop="name">
            <el-input v-model="ruleForm.name"></el-input>
          </el-form-item>
          <el-form-item label="密码" prop="password">
            <el-input v-model="ruleForm.password" show-password></el-input>
          </el-form-item>
          <el-form-item label="手机号" prop="phone">
            <el-input v-model="ruleForm.phone"></el-input>
          </el-form-item>
          <el-form-item label="验证码" prop="code">
            <el-input v-model="ruleForm.code" style="width: 60%"></el-input>
            <el-button style="width: 120px" v-show="ruleForm.codeStatus" @click.prevent="getCode">获取验证码</el-button>
            <el-button style="width: 120px" v-show="!ruleForm.codeStatus" disabled>{{ ruleForm.codeCount }}</el-button>
          </el-form-item>
          <el-form-item>
            <el-button type="primary" @click="submitForm('ruleForm')">注册</el-button>
            <el-button @click="toLogin">去登录</el-button>
          </el-form-item>
        </el-form>
      </el-card>
    </div>

  </div>
</template>

<script>
import * as login from "../../../network/login/login";

export default {
  name: "register",
  data() {
    return {
      ruleForm: {
        name: '',
        password: '',
        phone: '',
        code: '',
        codeCount: null,
        codeStatus: true
      },
      rules: {
        name: [
          {required: true, message: '请输入用户名', trigger: 'blur'},
          {min: 5, max: 12, message: '长度在 5 到 12 个字符', trigger: 'blur'}
        ],
        phone: [
          {
            required: true,
            message: '请输入手机号',
            trigger: 'blur'
          },
          {
            pattern: /^0{0,1}(13[0-9]|15[7-9]|153|156|18[7-9])[0-9]{8}$/,
            message: '手机号格式不对',
            trigger: 'blur'
          }

        ],
        password: [
          {required: true, message: '请输入密码', trigger: 'blur'},
          {min: 8, max: 12, message: '长度在 8 到 12 个字符', trigger: 'blur'}
        ],
        code: [
          {required: true, message: '请输入验证码', trigger: 'blur'}
        ],
      }
    };
  },
  methods: {
    submitForm(formName) {
      let _this = this;
      this.$refs[formName].validate((valid) => {
        if (valid) {
          login.register(_this.ruleForm.name, _this.ruleForm.phone, _this.ruleForm.password, _this.ruleForm.code).then(res => {
            console.log(res);
            if (res.data.code == 200) {
              _this.$message.success(res.data.message);
              _this.toLogin();
            } else {
              _this.$message.warning(res.data.message)
            }

          }).catch(err => {
            console.log(err);
          })
        } else {
          console.log('error submit!!');
          return false;
        }
      });
    },
    toLogin() {
      this.$router.push("/login");
    },
    getCode() {
      this.ruleForm.codeStatus = false;
      this.ruleForm.codeCount = 60;
      this.ruleForm.codeCount = setInterval(() => {
        if (this.ruleForm.codeCount > 0) {
          this.ruleForm.codeCount--;
        } else {
          this.ruleForm.codeStatus = true;
          this.ruleForm.codeCount = null;
        }
      }, 1000)

    }
  }
}
</script>

<style scoped>
.login-box {
  height: 100%;
  width: 100%;
  display: flex;
  justify-content: flex-end;
  align-items: center;
}

.el-card{
  border-radius: 25px;
}

.background_image{
  width:100%;
  height:100%;  /**宽高100%是为了图片铺满屏幕 */
  z-index:-1;
  position: absolute;
}

</style>
