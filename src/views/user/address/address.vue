<template>
  <div class="container">
    <div class="myheader">
      <tabbar></tabbar>
    </div>
    <div style="width: 100%;display: flex;justify-content: center;margin-top: 15px">
      <el-card style="width: 40%">
        <div slot="header" class="clearfix">
          <span>管理地址</span>
          <el-button style="float: right; padding: 3px 0" type="text" @click="addAddrShow">添加</el-button>
        </div>
        <div>
          <el-table
            :data="addrList"
            style="width: 100%">
            <el-table-column type="index" label="#"></el-table-column>
            <el-table-column prop="realName" label="取件人" width="150px"></el-table-column>
            <el-table-column prop="addr" label="地址"></el-table-column>
            <el-table-column label="操作" width="70px">
              <template slot-scope="scope">
                <el-button @click="deleteAddr(scope)" type="text">删除</el-button>
              </template>
            </el-table-column>
          </el-table>
        </div>
      </el-card>
    </div>
    <!--  添加地址  -->
    <el-dialog title="添加地址" width="30%" :visible.sync="addDiagShow">
      <el-form :model="addForm" :rules="rules" ref="addForm" label-width="100px">
        <el-form-item label="取件人" prop="realName">
          <el-input v-model="addForm.realName"></el-input>
        </el-form-item>
        <el-form-item label="详细地址" prop="addr">
          <el-input v-model="addForm.addr"></el-input>
        </el-form-item>
      </el-form>
      <span slot="footer" class="dialog-footer">
        <el-button type="primary" @click="addAddr">确 定</el-button>
      </span>
    </el-dialog>
  </div>
</template>

<script>
import tabbar from "../../../components/user/tabbar";
import * as user from "../../../network/admin/user/user"

export default {
  components: {
    tabbar,
  },
  name: "address",
  data() {
    return {
      addrList: [],
      addDiagShow: false,
      addForm: {
        realName: "",
        addr: ""
      },
      rules: {
        realName: [
          {required: true, message: '请输入取件人姓名', trigger: 'blur'},
        ],
        addr: [
          {required: true, message: '请输入详细地址', trigger: 'blur'},
        ]
      }
    }
  },
  mounted() {
    this.getAllAddress();
  },
  methods: {
    getAllAddress() {
      user.getAllAdress(window.localStorage.getItem("userId")).then(res => {
        this.addrList = res.data.data
      })
    },
    addAddrShow() {
      this.addDiagShow = true;
    },
    addAddr() {
      this.$refs["addForm"].validate((valid) => {
        if (valid) {
          user.addAddress(this.addForm.addr, window.localStorage.getItem("userId"), this.addForm.realName).then(res => {
            this.$message.success(res.data.message)
          }).catch(err => {
            console.log(err)
          })
          this.addDiagShow = false;
          this.getAllAddress();
        } else {
          console.log('error submit!!');
          return false;
        }
      });
    },
    deleteAddr(scope) {
      this.$confirm('此操作将永久删除 '+scope.row.addr+', 是否继续?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        user.deleteAddress(scope.row.id).then(res=>{
          this.$message.success(res.data.message)
          this.getAllAddress();
        })
      }).catch(() => {
        this.$message({
          type: 'info',
          message: '已取消删除'
        });
      });
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

</style>
