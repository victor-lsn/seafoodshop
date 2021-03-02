<template>
  <div>
    <el-breadcrumb separator="/">
      <el-breadcrumb-item>当前位置:</el-breadcrumb-item>
      <el-breadcrumb-item>产品管理</el-breadcrumb-item>
      <el-breadcrumb-item>商品管理</el-breadcrumb-item>
    </el-breadcrumb>
    <el-card style="margin-top: 15px">
      <div style="display: flex;margin-bottom: 15px;justify-content: space-between">
        <div>
          <el-input placeholder="商品名称" class="my-search-input" v-model="search.name"></el-input>
          <el-input placeholder="最低售价" class="my-search-input" v-model="search.lowPrice"></el-input>
          <el-input placeholder="最高售价" class="my-search-input" v-model="search.highPrice"></el-input>
          <el-cascader clearable :options="search.category" v-model="search.selectCategory" :props="{
                      checkStrictly:true,
                      expandTrigger: 'hover',
                      value: 'id',
                      label: 'name',
                      children: 'children'}"></el-cascader>
          <el-date-picker v-model="search.lowDate" type="date" placeholder="最低日期"></el-date-picker>
          <el-date-picker v-model="search.highDate" type="date" placeholder="最高日期"></el-date-picker>
          <el-button type="primary" icon="el-icon-search" @click="getAllGoods">搜索</el-button>
        </div>
        <div>
          <el-button type="primary" @click="addGoodFormShow">添加商品</el-button>
          <el-button type="success" @click="">批量导入</el-button>
        </div>
      </div>
      <el-table :data="pageInfo.list" border style="width: 100%">
        <el-table-column type="index" label="#"></el-table-column>
        <el-table-column prop="id" label="ID" width="100px"></el-table-column>
        <el-table-column prop="name" label="商品名称" width="100px"></el-table-column>
        <el-table-column prop="inPrice" label="进价" width="100px"></el-table-column>
        <el-table-column prop="outPrice" label="售价" width="100px"></el-table-column>
        <el-table-column prop="discount" label="折扣" width="100px"></el-table-column>
        <el-table-column prop="count" label="库存" width="200px"></el-table-column>
        <el-table-column prop="category.name" label="分类" width="200px"></el-table-column>
        <el-table-column prop="saleDate" label="上架日期" width="200px">
          <template slot-scope="scope">
            {{ scope.row.saleDate.substring(0, 10) }}
          </template>
        </el-table-column>
        <el-table-column prop="title" label="商品描述" width="300px"></el-table-column>
        <el-table-column fixed="right" label="操作" width="400px">
          <template slot-scope="scope">
            <el-button @click="" type="primary" size="small" icon="el-icon-search" @click="getGoodInfo(scope.row)">查看
            </el-button>
            <el-button @click="" type="warning" size="small" icon="el-icon-edit">编辑</el-button>
            <el-button @click="" type="success" size="small" icon="el-icon-picture-outline-round">管理图片</el-button>
            <el-button @click="" type="danger" size="small" icon="el-icon-delete">删除</el-button>
          </template>
        </el-table-column>
      </el-table>

      <!--   分页   -->
      <el-pagination style="margin-top: 15px"
                     @size-change="handleSizeChange"
                     @current-change="handleCurrentChange"
                     :current-page="currentPage"
                     :page-sizes="[10, 50, 100]"
                     :page-size="search.pageSize"
                     layout="total, sizes, prev, pager, next, jumper"
                     :total="pageInfo.total">
      </el-pagination>
    </el-card>

    <!-- 商品详情-->
    <el-dialog title="商品详情" :visible.sync="goodInfoDialog" width="30%">
      <el-form ref="form" :model="goodInfo" label-width="80px">
        <el-form-item label="商品名称">
          {{ goodInfo.name }}
        </el-form-item>
        <el-form-item label="进价">
          {{ goodInfo.inPrice }}
        </el-form-item>
        <el-form-item label="预售价">
          {{ goodInfo.outPrice }}
        </el-form-item>
        <el-form-item label="折扣">
          {{ goodInfo.discount }}
        </el-form-item>
        <el-form-item label="库存">
          {{ goodInfo.count }}
        </el-form-item>
        <el-form-item label="类别">
          {{ goodInfo.category.name }}
        </el-form-item>
        <el-form-item label="上架日期">
          {{ goodInfo.saleDate }}
        </el-form-item>
        <el-form-item label="标题">
          {{ goodInfo.title }}
        </el-form-item>
        <el-form-item label="详情">
          {{ goodInfo.info }}
        </el-form-item>
      </el-form>
    </el-dialog>

    <!--  添加商品  -->
    <el-dialog title="商品详情" :visible.sync="addGoodFormDialog" width="30%">
      <el-steps :active="addGoodForm.stepActive" finish-status="success" style="margin-bottom: 15px">
        <el-step title="基本信息"></el-step>
        <el-step title="图片"></el-step>
        <el-step title="完成"></el-step>
      </el-steps>
      <el-form ref="addGoodForm" :model="addGoodForm" label-width="80px" v-if="addGoodForm.stepActive == 0">
        <el-form-item label="商品名称">
          <el-input v-model="addGoodForm.name"></el-input>
        </el-form-item>
        <el-form-item label="进价">
          <el-input v-model="addGoodForm.inPince"></el-input>
        </el-form-item>
        <el-form-item label="售价">
          <el-input v-model="addGoodForm.outPrice"></el-input>
        </el-form-item>
        <el-form-item label="折扣">
          <el-input v-model="addGoodForm.discount"></el-input>
        </el-form-item>
        <el-form-item label="库存">
          <el-input v-model="addGoodForm.count"></el-input>
        </el-form-item>
        <el-form-item label="类别">
          <el-input v-model="addGoodForm.category"></el-input>
        </el-form-item>
        <el-form-item label="标题">
          <el-input v-model="addGoodForm.title"></el-input>
        </el-form-item>
        <el-form-item label="详情">
          <el-input type="textarea" :autosize="{ minRows: 5, maxRows: 50}" v-model="addGoodForm.info"></el-input>
        </el-form-item>
        <el-form-item>
          <el-button type="primary" @click="toSecondPic">下一步</el-button>
        </el-form-item>
      </el-form>
      <el-form v-if="addGoodForm.stepActive == 1">
        <el-form-item label="图片">
          <el-upload action="#" list-type="picture-card" :auto-upload="false">
            <i slot="default" class="el-icon-plus"></i>
            <div slot="file" slot-scope="{file}">
              <img class="el-upload-list__item-thumbnail" :src="file.url" alt="">
              <span class="el-upload-list__item-actions">
                <span class="el-upload-list__item-preview" @click="handlePictureCardPreview(file)">
                    <i class="el-icon-zoom-in"></i>
                </span>
                <span v-if="!disabled" class="el-upload-list__item-delete" @click="handleRemove(file)">
                  <i class="el-icon-delete"></i>
                </span>
              </span>
            </div>
          </el-upload>
        </el-form-item>
        <el-dialog :visible.sync="addGoodForm.smallPic">
          <img width="100%" :src="addGoodForm.dialogImageUrl" alt="">
        </el-dialog>
      </el-form>
    </el-dialog>

  </div>
</template>

<script>
import * as good from "../../../network/admin/good/goods"
import * as category from '../../../network/admin/category/category'

export default {
  name: "goods",
  data() {
    return {
      goodList: [],
      pageInfo: null,
      search: {
        pageNo: 1,
        pageSize: 10,
        name: "",
        lowPrice: "",
        highPrice: "",
        category: [],
        lowDate: null,
        highDate: null,
        selectCategory: ""
      },
      currentPage: 1,
      goodInfo: {
        category: {}
      },
      goodInfoDialog: false,
      addGoodFormDialog: false,
      addGoodForm: {
        name: "",
        inPince: null,
        outPrice: null,
        discount: null,
        count: "",
        category: "",
        saleDate: null,
        title: "",
        info: "",
        stepActive: 0,
        smallPic: false,
        pics: [],
        dialogImageUrl:""
      }
    }
  },
  mounted() {
    this.getAllGoods();
    this.getCategory();
  },
  methods: {
    //获取所有分类
    getCategory() {
      category.getAllCategory().then(res => {
        if (res.data.code == 200) {
          this.search.category = res.data.data;
        }
      }).catch(err => {
        console.log(err);
      })
    },
    getAllGoods() {
      good.getAllSeafood(this.search.name, this.search.lowPrice, this.search.highPrice,
        this.search.lowDate, this.search.highDate, this.search.selectCategory.toString(), this.search.pageNo, this.search.pageSize).then(res => {
        this.pageInfo = res.data.data;
      }).catch(err => {
        console.log(err);
      })
    },
    //修改每页显示的条数
    handleSizeChange(val) {
      console.log(`每页 ${val} 条`);
      this.search.pageSize = val;
      this.getAllGoods();
    },
    //修改页码
    handleCurrentChange(val) {
      console.log(`当前页: ${val}`);
      this.search.pageNo = val;
      this.getAllGoods();
    },
    //加载商品详情
    getGoodInfo(value) {
      good.getSeafoodById(value.id).then(res => {
        this.goodInfo = res.data.data;
        this.goodInfoDialog = true;
      }).catch(err => {
        console.log(err);
      })
    },
    addGoodFormShow() {
      this.addGoodFormDialog = true;
    },
    //去第二步添加图片
    toSecondPic() {
      this.addGoodForm.stepActive = 1;
    },
    //移除图片
    handleRemove(file) {
      console.log(file);
    },
    //缩略图放大
    handlePictureCardPreview(file) {
      this.addGoodForm.dialogImageUrl = file.url;
      this.addGoodForm.smallPic = true;
    },
  }
}
</script>

<style scoped>
.my-search-input {
  width: 8%;
}
</style>
