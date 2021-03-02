<template>
  <div>
    <el-breadcrumb separator="/">
      <el-breadcrumb-item>当前位置:</el-breadcrumb-item>
      <el-breadcrumb-item>系统管理</el-breadcrumb-item>
      <el-breadcrumb-item>权限管理</el-breadcrumb-item>
    </el-breadcrumb>
    <el-card style="margin-top: 15px">
      <el-button type="primary" @click="addPermissionDialogShow = true">新增权限</el-button>
      <!--      表格-->
      <el-table
        :data="menuList"
        style="width: 100%;margin-top: 15px;"
        row-key="id"
        border
        :tree-props="{children: 'children', hasChildren: 'hasChildren'}">
        <el-table-column
          prop="id"
          label="ID"
          sortable
          width="180">
        </el-table-column>
        <el-table-column
          prop="name"
          label="名称"
          width="180">
        </el-table-column>
        <el-table-column
          prop="path"
          label="路径">
        </el-table-column>
        <el-table-column
          prop="level"
          label="等级">
          <template slot-scope="scope">
            <el-tag v-if="scope.row.level == 1" type="primary">1 级</el-tag>
            <el-tag v-if="scope.row.level == 2" type="warning">2 级</el-tag>
          </template>
        </el-table-column>
        <el-table-column
          prop="icon"
          label="图标">
          <template slot-scope="scope">
            <i :class="scope.row.icon" style="font-size: 20px"></i>
          </template>
        </el-table-column>
        <el-table-column
          label="操作">
          <template slot-scope="scope">
            <el-button size="mini" type="primary" icon="el-icon-edit" @click="">修改</el-button>
          </template>
        </el-table-column>
      </el-table>
    </el-card>

    <!-- 增加权限弹出框-->
    <el-dialog
      title="增加权限"
      :visible.sync="addPermissionDialogShow"
      width="30%">
      <el-tabs v-model="activeName" type="card" @tab-click="handleClick">
        <el-tab-pane label="一级权限" name="first">
          <!-- 一级权限         -->
          <el-form ref="firstForm" :model="firstForm" label-width="80px" :rules="firstRules">
            <el-form-item label="名称" prop="name">
              <el-input v-model="firstForm.name" required></el-input>
            </el-form-item>
            <el-form-item label="图标" prop="icon">
              <el-input v-model="firstForm.icon" required></el-input>
            </el-form-item>
            <el-form-item>
              <el-button type="primary" @click="submitForm1('firstForm')">增加</el-button>
            </el-form-item>
          </el-form>
        </el-tab-pane>
        <el-tab-pane label="二级权限" name="second">
          <!-- 二级权限         -->
          <el-form ref="secondForm" :model="secondForm" label-width="80px" :rules="firstRules">
            <el-form-item label="名称" prop="name">
              <el-input v-model="secondForm.name"></el-input>
            </el-form-item>
            <el-form-item label="路径" prop="path">
              <el-input v-model="secondForm.path"></el-input>
            </el-form-item>
            <el-form-item label="图标" prop="icon">
              <el-input v-model="secondForm.icon"></el-input>
            </el-form-item>
            <el-form-item label="父权限" prop="parent">
              <el-select v-model="secondForm.parent" placeholder="请选择">
                <el-option
                  v-for="item in menuList"
                  :key="item.id"
                  :label="item.name"
                  :value="item.id">
                </el-option>
              </el-select>
            </el-form-item>
            <el-form-item>
              <el-button type="primary" @click="submitForm2('secondForm')">增加</el-button>
            </el-form-item>
          </el-form>
        </el-tab-pane>
      </el-tabs>
    </el-dialog>
  </div>
</template>

<script>
import * as menu from '../../../network/admin/menu/menu'

export default {
  name: "permission",
  data() {
    return {
      menuList: [],
      addPermissionDialogShow: false,
      activeName: 'first',
      firstForm: {
        name: "",
        icon: ""
      },
      secondForm: {
        name: "",
        icon: "",
        parent: null,
        path: ""
      },
      firstRules: {
        name: [
          {required: true, message: '请输入权限名称', trigger: 'blur'},
        ],
        icon: [
          {required: true, message: '请填写图标代码', trigger: 'blur'}
        ],
        parent: [
          {required: true, message: '请选择父级权限', trigger: 'change'}
        ],
        path: [
          {required: true, message: '请填写路径', trigger: 'blur'}
        ],
      }
    }
  },
  mounted() {
    this.getMenu()
  },
  methods: {
    getMenu() {
      menu.getMenu().then(res => {
        console.log(res);
        if (res.data.code == 200) {
          this.menuList = res.data.data
        }
      }).catch(err => {
        console.log(err);
      })
    },
    submitForm1(formName) {
      this.$refs[formName].validate((valid) => {
        if (valid) {
          menu.addMenu(this.firstForm.name, null, null, this.firstForm.icon).then(res => {
            if (res.data.code == 200) {
              this.$message.success(res.data.message)
              this.addPermissionDialogShow = false;
            } else {
              this.$message.error(res.data.message)
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
    submitForm2(formName) {
      this.$refs[formName].validate((valid) => {
        if (valid) {
          menu.addMenu(this.secondForm.name, this.secondForm.path, this.secondForm.parent, this.secondForm.icon).then(res => {
            if (res.data.code == 200) {
              this.$message.success(res.data.message);
              this.addPermissionDialogShow = false;
            } else {
              this.$message.error(res.data.message)
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
  }
}
</script>

<style scoped>

</style>
