<template>
  <div>
    <el-breadcrumb separator="/">
      <el-breadcrumb-item>当前位置:</el-breadcrumb-item>
      <el-breadcrumb-item>系统管理</el-breadcrumb-item>
      <el-breadcrumb-item>角色管理</el-breadcrumb-item>
    </el-breadcrumb>
    <el-card style="margin-top: 15px;">
      <el-button type="primary" @click="addRoleDialogShow = true" size="mini">新增角色</el-button>
      <el-table border :data="roleList" style="width: 100%;margin-top: 10px">
        <el-table-column type="expand">
          <template slot-scope="scope">
            <div v-for="item in scope.row.children" style="display: flex;align-items: center">
              <el-tag>{{ item.name }}</el-tag>
              <i class="el-icon-caret-right"></i>
              <div style="display: flex;">
                <el-tag v-for="sub in item.children" :key="sub.id" type="warning" style="margin: 10px">{{ sub.name }}
                </el-tag>
              </div>
            </div>
            <div v-if="scope.row.children.length == 0"
                 style="display: flex;justify-content: center;align-items: center">
              <div>无</div>
            </div>
          </template>
        </el-table-column>
        <el-table-column label="#" type="index"></el-table-column>
        <el-table-column label="角色ID" prop="id"></el-table-column>
        <el-table-column label="角色名称" prop="name"></el-table-column>
        <el-table-column label="角色描述" prop="roleDesc"></el-table-column>
        <el-table-column label="操作">
          <template slot-scope="scope">
            <el-button size="mini" type="warning" icon="el-icon-setting" @click="addPermissionDialog(scope.row.id)">分配权限
            </el-button>
            <el-button size="mini" type="danger" icon="el-icon-delete" @click="deleteRole(scope.row.id)">删除</el-button>
          </template>
        </el-table-column>
      </el-table>
    </el-card>

    <!--  添加角色模态框  -->
    <el-dialog title="增加角色" :visible.sync="addRoleDialogShow" width="30%">
      <el-form :model="addRoleForm" :rules="addRoleFoemRules" ref="addRoleForm" label-width="100px"
               class="demo-ruleForm">
        <el-form-item label="角色名称" prop="name">
          <el-input v-model="addRoleForm.name"></el-input>
        </el-form-item>
        <el-form-item label="角色描述" prop="describe">
          <el-input v-model="addRoleForm.describe"></el-input>
        </el-form-item>
        <el-form-item>
          <el-button type="primary" @click="submitForm('addRoleForm')">添加</el-button>
        </el-form-item>
      </el-form>
    </el-dialog>

    <!--  分配权限  -->
    <el-dialog title="分配权限" :visible.sync="addPermissionDialogShow" width="30%">
      <el-tree
        :data="menuList"
        show-checkbox
        default-expand-all
        node-key="id"
        ref="menuListTree"
        highlight-current
        :props="defaultProps">
      </el-tree>
      <div style="display: flex;justify-content: flex-end;margin-top: 20px">
        <el-button type="primary" @click="updateRolePermission">修改</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import * as role from '../../../network/admin/role/role'
import * as menu from '../../../network/admin/menu/menu'

export default {
  name: "role",
  data() {
    return {
      addRoleDialogShow: false,
      roleList: [],
      addRoleForm: {
        name: "",
        describe: ""
      },
      addRoleFoemRules: {
        name: [
          {required: true, message: '请输入角色名称', trigger: 'blur'},
          {min: 2, max: 8, message: '长度在 2 到 8 个字符', trigger: 'blur'}
        ],
        describe: [
          {required: true, message: '请输入角色描述', trigger: 'blur'},
          {min: 1, max: 32, message: '长度在 1 到 32 个字符', trigger: 'blur'}
        ]
      },
      addPermissionDialogShow: false,
      menuList: [],
      defaultProps: {
        children: 'children',
        label: 'name'
      },
      checkedId: [],
      addPermissionRoleId: null,
    }
  },
  mounted() {
    this.getAllRole();
  },
  methods: {
    getAllRole() {
      role.getAllRole().then(res => {
        this.roleList = res.data.data;
      }).catch(err => {
        console.log(err);
      })
    },
    //添加角色
    submitForm(formName) {
      this.$refs[formName].validate((valid) => {
        if (valid) {
          //发送请求添加
          role.addRole(this.addRoleForm.name, this.addRoleForm.describe).then(res => {
            if (res.data.code == 200) {
              this.$notify.success(res.data.message);
              this.addRoleDialogShow = false;
              this.getAllRole();
            } else {
              this.$notify.error(res.data.message);
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
    //删除角色
    deleteRole(roleId) {
      this.$confirm("确认删除ID为" + roleId + "的角色吗", '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        role.deleteRole(roleId).then(res => {
          if (res.data.code == 200) {
            this.$notify.success(res.data.message);
            this.getAllRole()
          } else {
            this.$notify.error(res.data.message);
          }
        }).catch(err => {
          console.log(err);
        })
      }).catch(() => {
        this.$message.warning("已取消删除")
      })
    },
    //修改角色权限
    addPermissionDialog(id) {
      menu.getAllMenu().then(res => {
        if (res.data.code == 200) {
          this.menuList = res.data.data;
          this.addPermissionDialogShow = true;
          this.handleCheckedPermissionList(id);
        }
      })
    },
    //获取角色的所有权限二级目录ID并设置属性结构选择
    handleCheckedPermissionList(id) {
      role.getRoleById(id).then(res => {
        this.checkedId = res.data.data;
        this.$refs["menuListTree"].setCheckedKeys(res.data.data);
        this.addPermissionRoleId = id;
      })
    },
    //发送修改角色权限请求
    updateRolePermission() {
      let currentKeys = this.$refs["menuListTree"].getCheckedKeys();
      role.addRolePermission(this.addPermissionRoleId, currentKeys.toString()).then(res => {
        if (res.data.code == 200) {
          this.$notify.success(res.data.message);
          this.getAllRole();
          this.addPermissionDialogShow = false;
        }
      }).catch(err => {

      })
    }
  }
}
</script>

<style scoped>

</style>
