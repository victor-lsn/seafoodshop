<template>
  <div>
    <el-breadcrumb separator="/">
      <el-breadcrumb-item>当前位置:</el-breadcrumb-item>
      <el-breadcrumb-item>用户管理</el-breadcrumb-item>
      <el-breadcrumb-item>用户列表</el-breadcrumb-item>
    </el-breadcrumb>
    <el-card :gutter="20" style="margin-top: 15px">
      <div style="display: flex;margin-bottom: 10px">
        <el-input placeholder="用户名" class="my-search-input" v-model="search.username" size="mini"></el-input>
        <el-input placeholder="手机号" class="my-search-input" v-model="search.phone" size="mini"></el-input>
        <el-select filterable placeholder="角色" class="my-search-input" v-model="search.role" size="mini" clearable>
          <el-option
            v-for="item in options"
            :key="item.value"
            :label="item.label"
            :value="item.value">
          </el-option>
        </el-select>
        <el-button type="primary" icon="el-icon-search" @click="getAllUser" size="mini">搜索</el-button>
      </div>
      <el-table ref="userTable" :data="pageInfo.list" border stripe style="width: 100%;font-size: 13px">
        <el-table-column label="序号" type="index"></el-table-column>
        <el-table-column prop="id" label="ID"></el-table-column>
        <el-table-column prop="name" label="姓名"></el-table-column>
        <el-table-column prop="password" label="密码"></el-table-column>
        <el-table-column prop="phone" label="手机号"></el-table-column>
        <el-table-column prop="roleName" label="角色"></el-table-column>
        <el-table-column prop="flag" label="是否启用">
          <template slot-scope="scope">
            <el-switch size="mini" v-model="scope.row.status" @change="setStatus(scope.row)"></el-switch>
          </template>
        </el-table-column>
        <el-table-column label="操作">
          <template slot-scope="scope">
            <el-button type="info" icon="el-icon-search" @click="getUserInfo(scope.row.id)" circle size="mini"></el-button>
            <el-button type="primary" icon="el-icon-user" circle @click="addUserRole(scope.row)" size="mini"></el-button>
          </template>
        </el-table-column>
      </el-table>

      <el-pagination style="margin-top: 15px"
                     @size-change="handleSizeChange"
                     @current-change="handleCurrentChange"
                     :current-page="currentPage4"
                     :page-sizes="[10, 50, 100]"
                     :page-size="search.pageSize"
                     layout="total, sizes, prev, pager, next, jumper"
                     :total="pageInfo.total">
      </el-pagination>


      <!--   用户详情   -->
      <el-dialog title="用户详情" :visible.sync="userInfoDialog" width="35%">
        <el-form :model="userInfo" style="display: flex;flex-wrap: wrap;justify-content: space-between">
          <el-form-item label="用户名" style="width: 48%">
            <el-input disabled v-model="userInfo.name" placeholder="用户名"></el-input>
          </el-form-item>
          <el-form-item label="电话">
            <el-input disabled v-model="userInfo.phone" placeholder="电话"></el-input>
          </el-form-item>
          <el-form-item label="角色">
            <el-input disabled v-model="userInfo.roleName" placeholder="角色"></el-input>
          </el-form-item>
          <el-form-item label="启用状态">
            <el-input disabled :placeholder="userInfo.flag == 0 ? '禁用中' : '使用中'"></el-input>
          </el-form-item>
        </el-form>
        <el-table :data="userInfo.addrs" style="width: 100%">
          <el-table-column type="index"></el-table-column>
          <el-table-column prop="realName" label="收货人" width="180"></el-table-column>
          <el-table-column prop="addr" label="收货人" width="180"></el-table-column>
        </el-table>
      </el-dialog>

      <!--   修改用户角色   -->
      <el-dialog
        title="分配角色"
        :visible.sync="addUserRoleShow" width="28%" :before-close="addUserRoleClose">
        <el-form>
          <el-form-item label="当前角色">
            <el-tag>{{ addUserRoleForm.selectorRoleName }}</el-tag>
          </el-form-item>
          <el-form-item label="活动名称" prop="name" style="width: 100%">
            <el-select filterable placeholder="请选择角色" class="my-search-input"
                       v-model="addUserRoleForm.selectorRoleValue" style="width: 30%">
              <el-option
                v-for="item in options"
                :key="item.value"
                :label="item.label"
                :value="item.value">
              </el-option>
            </el-select>
          </el-form-item>
          <el-form-item>
            <el-button type="primary" @click="updateUserRole">修改</el-button>
          </el-form-item>
        </el-form>
      </el-dialog>
    </el-card>
  </div>
</template>

<script>
import * as user from '../../../network/admin/user/user'
import * as role from '../../../network/admin/role/role'
import {getAllRole} from "../../../network/admin/role/role";

export default {
  name: "user",
  data() {
    return {
      userList: [],
      pageInfo: null,
      options: [],
      currentPage4: 1,
      search: {
        pageNo: 1,
        pageSize: 10,
        username: "",
        phone: "",
      },
      userInfo: {},
      userInfoDialog: false,
      addUserRoleShow: false,
      addUserRoleForm: {
        selectorRoleName: "",
        selectorRoleValue: "",
        selectorUserId: ""
      },

    }
  },
  mounted() {
    this.getAllUser();
    this.getAllRole();
  },
  methods: {
    getAllUser() {
      user.getUserPage(this.search).then(res => {
        if (res.data.code == 200) {
          this.pageInfo = res.data.data;
        }
      }).catch(err => {
        console.log(err);
      })
    },
    //获取角色列表
    getAllRole() {
      role.getAllRole().then(res => {
        for (let i = 0; i < res.data.data.length; i++) {
          console.log(res.data.data[i])
          this.options.push({
            "value": res.data.data[i].id,
            "label": res.data.data[i].name
          });
        }

        res.data.data
      })
    },
    //修改每页显示的条数
    handleSizeChange(val) {
      console.log(`每页 ${val} 条`);
      this.search.pageSize = val;
      this.getAllUser();
    },
    //修改页码
    handleCurrentChange(val) {
      console.log(`当前页: ${val}`);
      this.search.pageNo = val;
      this.getAllUser();
    },
    //修改使用状态
    setStatus(event) {
      console.log(event);
      if (event.status) {
        event.flag = 1;
      } else {
        event.flag = 0;
      }
      user.updateStatus(event.id, event.flag).then(res => {
        if (res.data.code == 200) {
          this.$notify.success(res.data.message)
        } else {
          this.$notify.warning(res.data.message)
        }
      }).catch(err => {
        console.log(err);
      })
    },
    addUserRole(row) {
      this.addUserRoleForm.selectorRoleName = row.roleName;
      this.addUserRoleForm.selectorUserId = row.id;
      this.addUserRoleShow = true;
      console.log(this.addUserRoleForm)
    },
    addUserRoleClose() {
      this.addUserRoleForm.selectorRoleValue = "";
      this.addUserRoleShow = false;
    },
    //修改用户角色
    updateUserRole() {
      console.log(this.addUserRoleForm)
      if (this.addUserRoleForm.selectorRoleValue == "" && this.addUserRoleForm.selectorRoleValue != 0) {
        this.addUserRoleShow = false;
        this.addUserRoleForm.selectorRoleValue = "";
        return;
      }
      //更新角色
      user.updateRole(this.addUserRoleForm.selectorUserId, this.addUserRoleForm.selectorRoleValue).then(res => {
        if (res.data.code == 200) {
          this.$notify.success(res.data.message);
          this.addUserRoleShow = false;
        } else {
          this.$notify.error(re.data.message)
        }
      })
    },
    //查询单个用户的详细信息
    getUserInfo(userId) {
      user.getUserInfo(userId).then(res => {
        if (res.data.code == 200) {
          this.userInfo = res.data.data;
          this.userInfoDialog = true;
        }
      }).catch(err => {
        console.log(err);
      })
    }
  }
}
</script>

<style scoped>
.my-search-input {
  width: 15%;
}
</style>
