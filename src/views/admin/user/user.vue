<template>
  <div>
    <el-breadcrumb separator="/">
      <el-breadcrumb-item>当前位置:</el-breadcrumb-item>
      <el-breadcrumb-item>用户管理</el-breadcrumb-item>
      <el-breadcrumb-item>用户列表</el-breadcrumb-item>
    </el-breadcrumb>
    <el-card :gutter="20" style="margin-top: 15px">
      <div style="display: flex;margin-bottom: 15px">
        <el-input placeholder="用户名" class="my-search-input" v-model="search.username"></el-input>
        <el-input placeholder="手机号" class="my-search-input" v-model="search.phone"></el-input>
        <el-select filterable placeholder="角色" class="my-search-input" v-model="search.role">
          <el-option
            v-for="item in options"
            :key="item.value"
            :label="item.label"
            :value="item.value">
          </el-option>
        </el-select>
        <el-button type="primary" icon="el-icon-search" @click="getAllUser">搜索</el-button>
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
            <el-switch v-model="scope.row.status" @change="setStatus(scope.row)"></el-switch>
          </template>
        </el-table-column>
        <el-table-column label="操作">
          <el-button type="info" icon="el-icon-search" circle></el-button>
          <el-button type="primary" icon="el-icon-user" circle></el-button>
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
    </el-card>
  </div>
</template>

<script>
import * as user from '../../../network/admin/user/user'

export default {
  name: "user",
  data() {
    return {
      userList: [],
      pageInfo: null,
      options: [{
        value: '1',
        label: '黄金糕'
      }, {
        value: '0',
        label: '双皮奶'
      }, {
        value: '3',
        label: '蚵仔煎'
      }, {
        value: '4',
        label: '龙须面'
      }, {
        value: '5',
        label: '北京烤鸭'
      }],
      currentPage4: 1,
      search: {
        pageNo: 1,
        pageSize: 10,
        username: "",
        phone: "",
      }
    }
  },
  mounted() {
    this.getAllUser();
  },
  methods: {
    getAllUser() {
      user.getUserPage(this.search).then(res => {
        if (res.data.code == 200) {
          this.pageInfo = res.data.data;
          console.log(this.pageInfo);
        }
      }).catch(err => {
        console.log(err);
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
          this.$message.success(res.data.message)
        } else {
          this.$message.warning(res.data.message)
        }
      }).catch(err => {
        console.log(err);
      })
    },
    //修改用户角色
    setRole() {

    },
    //查询单个用户的详细信息
    getUserInfo(userId){

    }
  }
}
</script>

<style scoped>
.my-search-input {
  width: 15%;
}
</style>
