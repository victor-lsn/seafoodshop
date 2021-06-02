<template>
  <div>
    <el-breadcrumb separator="/">
      <el-breadcrumb-item>当前位置:</el-breadcrumb-item>
      <el-breadcrumb-item>媒体管理</el-breadcrumb-item>
      <el-breadcrumb-item>新闻管理</el-breadcrumb-item>
    </el-breadcrumb>
    <el-card style="margin-top: 15px">
      <div style="display: flex;justify-content: space-between">
        <div>
          <el-date-picker v-model="search.lowDate" type="date" placeholder="最低日期" size="mini"></el-date-picker>
          <el-date-picker v-model="search.highDate" type="date" placeholder="最高日期" size="mini"></el-date-picker>
          <el-button type="primary" icon="el-icon-search" @click="getAllNews" size="mini">搜索</el-button>
        </div>
        <el-button type="primary" @click="addDialog = true" size="mini">添加通知</el-button>
      </div>
      <el-table :data="newsList" style="width: 100%;margin-top: 10px" border>
        <el-table-column type="index" label="#"></el-table-column>
        <el-table-column prop="content" label="新闻详情"></el-table-column>
        <el-table-column prop="createDate" label="发布日期" width="180">
          <template slot-scope="scope">
            {{ scope.row.createDate.substring(0, 19).replace("T", " ") }}
          </template>
        </el-table-column>
        <el-table-column label="操作" width="200px">
          <template slot-scope="scope">
            <el-button type="warning" size="mini" icon="el-icon-edit" @click="toUpdate(scope.row)">编辑</el-button>
            <el-button type="danger" size="mini" icon="el-icon-delete" @click="deleteNews(scope.row)">删除</el-button>
          </template>
        </el-table-column>
      </el-table>
      <el-pagination style="margin-top: 15px" @size-change="handleSizeChange" @current-change="handleCurrentChange"
                     :current-page="currentPage4"
                     :page-sizes="[10, 50, 100]"
                     :page-size="search.pageSize"
                     layout="total, sizes, prev, pager, next, jumper"
                     :total="totalSize">
      </el-pagination>
    </el-card>


    <!--  添加  -->
    <el-dialog
      title="添加通知"
      :visible.sync="addDialog"
      width="30%">
      <el-input type="textarea" autosize v-model="addContent"></el-input>
      <span slot="footer" class="dialog-footer">
          <el-button type="primary" @click="addNews">确 定</el-button>
        </span>
    </el-dialog>

    <!--  修改  -->
    <el-dialog
      title="修改通知"
      :visible.sync="updateDialog"
      width="30%">
      <el-input type="textarea" autosize v-model="updateContent"></el-input>
      <span slot="footer" class="dialog-footer">
          <el-button type="primary" @click="updateNews">确 定</el-button>
        </span>
    </el-dialog>

  </div>
</template>

<script>
import * as news from "../../../network/admin/news/news"
import {updateNews} from "../../../network/admin/news/news";

export default {
  name: "news",
  data() {
    return {
      newsList: [],
      search: {
        lowDate: null,
        highDate: null,
        pageNo: 1,
        pageSize: 10
      },
      addDialog: false,
      addContent: "",
      updateDialog: false,
      updateNewsId: "",
      updateContent: "",
      currentPage4: 1,
      totalSize: 0,
    }
  },
  mounted() {
    this.getAllNews()
  },
  methods: {
    getAllNews() {
      news.getAllNews(this.search.lowDate, this.search.highDate, this.search.pageNo, this.search.pageSize).then(res => {
        this.newsList = res.data.data.list;
        this.totalSize = res.data.data.total;
      })
    },
    toUpdate(row) {
      this.updateDialog = true;
      this.updateNewsId = row.id;
      this.updateContent = row.content
    },
    updateNews() {
      news.updateNews(this.updateNewsId, this.updateContent).then(res => {
        this.$notify.success(res.data.message);
        this.updateDialog = false;
        this.updateContent = "";
        this.getAllNews();
      })
    },
    deleteNews(row) {
      this.$confirm('此操作将永久删除该文件, 是否继续?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        news.deleteNews(row.id).then(res => {
          this.$notify.success(res.data.message);
          this.getAllNews()
        })
      }).catch(err => {
        this.$notify.warning("已经取消删除")
      })
    },
    addNews() {
      if (this.addContent.length > 0) {
        news.addNews(this.addContent).then(res => {
          this.$notify.success(res.data.message);
          this.addDialog = false;
          this.addContent = "";
          this.getAllNews()
        })
      }
    },
    handleSizeChange(val) {
      this.search.pageSize = val;
      this.getAllNews()
    },
    handleCurrentChange(val) {
      this.search.pageNo = val;
      this.getAllNews();
    }
  }
}
</script>

<style scoped>

</style>
