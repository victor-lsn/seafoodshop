<template>
  <div>
    <el-breadcrumb separator="/">
      <el-breadcrumb-item>当前位置:</el-breadcrumb-item>
      <el-breadcrumb-item>产品管理</el-breadcrumb-item>
      <el-breadcrumb-item>商品管理</el-breadcrumb-item>
    </el-breadcrumb>
    <el-card style="margin-top: 15px">
      <div style="display: flex;margin-bottom: 10px;">
        <div style="display: flex;justify-content: center;align-items: flex-start">
          <el-input placeholder="商品名称" class="my-search-input" v-model="search.name" size="mini"></el-input>
          <el-input placeholder="最低售价" class="my-search-input" v-model="search.lowPrice" size="mini"></el-input>
          <el-input placeholder="最高售价" class="my-search-input" v-model="search.highPrice" size="mini"></el-input>
          <el-cascader clearable :options="search.category" v-model="search.selectCategory" :props="{
                      expandTrigger: 'hover',
                      value: 'id',
                      label: 'name',
                      children: 'children'}" size="mini"></el-cascader>
          <el-date-picker v-model="search.lowDate" type="date" placeholder="最低日期" size="mini"></el-date-picker>
          <el-date-picker v-model="search.highDate" type="date" placeholder="最高日期" size="mini"></el-date-picker>
          <el-button icon="el-icon-search" type="primary" @click="getAllGoods" size="mini" style="margin-right: 5px">搜索</el-button>
        </div>
        <div>
          <el-button type="primary" @click="addGoodFormShow" size="mini">添加商品</el-button>
          <el-button type="success" @click="batchFileDialog = true" size="mini">批量导入</el-button>
          <el-button class="el-button el-button--warning" @click="downExcel" size="mini">模板下载</el-button>
        </div>
      </div>
      <el-table :data="pageInfo.list" border style="width: 100%">
        <el-table-column type="index" label="#"></el-table-column>
        <el-table-column prop="id" label="ID" width="100px"></el-table-column>
        <el-table-column prop="name" label="商品名称" width="140px"></el-table-column>
        <el-table-column prop="inPrice" label="进价" width="100px"></el-table-column>
        <el-table-column prop="outPrice" label="预售价" width="100px"></el-table-column>
        <el-table-column prop="discount" label="折扣" width="100px"></el-table-column>
        <el-table-column label="实售价" width="100px">
          <template slot-scope="scope">
            {{ scope.row.outPrice}}
          </template>
        </el-table-column>
        <el-table-column prop="saleCount" label="销量" width="100px"></el-table-column>
        <el-table-column prop="count" label="库存" width="100px"></el-table-column>
        <el-table-column prop="weight" label="规格" width="100px"></el-table-column>
        <el-table-column prop="seafoodSource" label="产地" width="200px"></el-table-column>
        <el-table-column prop="category.name" label="分类" width="100px"></el-table-column>
        <el-table-column prop="saleDate" label="上架日期" width="200px">
          <template slot-scope="scope">
            {{ scope.row.saleDate.substring(0, 10) }}
          </template>
        </el-table-column>
        <el-table-column prop="title" label="商品标题" width="300px"></el-table-column>
        <el-table-column fixed="right" label="操作" width="280px">
          <template slot-scope="scope">
            <el-button size="mini" @click="" type="primary" icon="el-icon-search" @click="getGoodInfo(scope.row)">查看
            </el-button>
            <el-button size="mini" @click="" type="warning" icon="el-icon-edit" @click="updateGoodInfoShow(scope.row)">
              编辑
            </el-button>
            <!--            <el-button @click="" type="success" size="small" icon="el-icon-picture-outline-round">管理图片</el-button>-->
            <el-button size="mini" @click="" type="danger" icon="el-icon-delete" @click="deleteGood(scope.row)">删除</el-button>
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
    <el-dialog title="商品详情" :visible.sync="goodInfoDialog" width="40%">
      <el-form ref="form" :model="goodInfo" label-width="80px">
        <div style="display: flex">
          <el-form-item label="商品名称">
            <el-input v-model="goodInfo.name" disabled></el-input>
          </el-form-item>
          <el-form-item label="进价">
            <el-input v-model="goodInfo.inPrice" disabled></el-input>
          </el-form-item>
        </div>
        <div style="display: flex">
          <el-form-item label="预售价">
            <el-input disabled v-model="goodInfo.outPrice"></el-input>
          </el-form-item>
          <el-form-item label="折扣">
            <el-input disabled v-model=" goodInfo.discount"></el-input>
          </el-form-item>
        </div>
        <div style="display: flex">
          <el-form-item label="库存">
            <el-input disabled v-model="goodInfo.count"></el-input>
          </el-form-item>
          <el-form-item label="类别">
            <el-input disabled v-model="goodInfo.category.name"></el-input>
          </el-form-item>
        </div>
        <div style="display: flex">
          <el-form-item label="规格kg">
            <el-input disabled v-model="goodInfo.weight"></el-input>
          </el-form-item>
          <el-form-item label="产地">
            <el-input disabled v-model="goodInfo.seafoodSource"></el-input>
          </el-form-item>
        </div>
        <div style="display: flex">
          <el-form-item label="上架日期">
            <el-input disabled v-model="(goodInfo.saleDate+' ').substring(0,10)"></el-input>
          </el-form-item>
          <el-form-item label="标题">
            <el-input disabled v-model="goodInfo.title"></el-input>
          </el-form-item>
        </div>
        <el-form-item label="详情">
          <el-input type="textarea" disabled :autosize="{ minRows: 5, maxRows: 50}" v-model="goodInfo.info"></el-input>
        </el-form-item>
        <el-form-item label="图片">
          <el-upload disabled action="" list-type="picture-card" :file-list="goodInfo.pics">
            <i slot="default" class="el-icon-plus"></i>
            <div slot="file" slot-scope="{file}">
              <img class="el-upload-list__item-thumbnail" :src="basePicUrl+file.name" alt="">
            </div>
          </el-upload>
        </el-form-item>
      </el-form>
    </el-dialog>

    <!--  添加商品  -->
    <el-dialog title="商品详情" :visible.sync="addGoodFormDialog" width="40%" @close="addGoodFormDialogClose">
      <el-steps :active="addGoodForm.stepActive" finish-status="success" style="margin-bottom: 15px">
        <el-step title="基本信息"></el-step>
        <el-step title="图片"></el-step>
        <el-step title="完成"></el-step>
      </el-steps>
      <el-form ref="addGoodForm" :model="addGoodForm" :rules="addGoodFormRules" label-width="80px"
               v-if="addGoodForm.stepActive == 0">
        <div style="display: flex">
          <el-form-item label="商品名称" prop="name">
            <el-input v-model="addGoodForm.name"></el-input>
          </el-form-item>
          <el-form-item label="进价" prop="inPince">
            <el-input v-model.number="addGoodForm.inPince"></el-input>
          </el-form-item>
        </div>
        <div style="display: flex">
          <el-form-item label="售价" prop="outPrice">
            <el-input v-model.number="addGoodForm.outPrice"></el-input>
          </el-form-item>
          <el-form-item label="折扣" prop="discount">
            <el-input v-model.number="addGoodForm.discount"></el-input>
          </el-form-item>
        </div>
        <div style="display: flex">
          <el-form-item label="库存" prop="count">
            <el-input v-model.number="addGoodForm.count"></el-input>
          </el-form-item>
          <el-form-item label="类别" prop="category">
            <el-cascader clearable :options="search.category" v-model="addGoodForm.category" :props="{
                      expandTrigger: 'hover',
                      value: 'id',
                      label: 'name',
                      children: 'children'}"></el-cascader>
          </el-form-item>
        </div>
        <div style="display: flex">
          <el-form-item label="规格kg" prop="weight">
            <el-input v-model.number="addGoodForm.weight"></el-input>
          </el-form-item>
          <el-form-item label="产地" prop="seafoodSource">
            <el-input v-model.number="addGoodForm.seafoodSource"></el-input>
          </el-form-item>
        </div>
        <el-form-item label="标题" prop="title">
          <el-input v-model="addGoodForm.title"></el-input>
        </el-form-item>
        <el-form-item label="详情" prop="info">
          <el-input type="textarea" :autosize="{ minRows: 5, maxRows: 50}" v-model="addGoodForm.info"></el-input>
        </el-form-item>
        <el-form-item>
          <el-button type="primary" @click="toSecondPic('addGoodForm')">下一步</el-button>
        </el-form-item>
      </el-form>
      <!--   添加图片模态框   -->
      <el-form v-if="addGoodForm.stepActive == 1">
        <span style="margin-bottom: 15px;display: block;font-size: 18px">图片</span>
        <el-form-item>
          <el-upload ref="addPicUpload" action="" list-type="picture-card" :file-list="addGoodForm.pics"
                     accept=".png,.jpg" :on-change="onChangeFile" :http-request="addGood" :auto-upload="false">
            <i slot="default" class="el-icon-plus"></i>
            <div slot="file" slot-scope="{file}">
              <img class="el-upload-list__item-thumbnail" :src="file.url" :alt="file.name">
              <span class="el-upload-list__item-actions">
                <span class="el-upload-list__item-preview" @click="handlePictureCardPreview(file)">
                    <i class="el-icon-zoom-in"></i>
                </span>
                <span class="el-upload-list__item-delete" @click="handleRemove(file)">
                  <i class="el-icon-delete"></i>
                </span>
              </span>
            </div>
          </el-upload>
        </el-form-item>
        <el-form-item>
          <el-button type="primary" @click="addGood">添加</el-button>
        </el-form-item>
        <el-dialog :visible.sync="addGoodForm.smallPic">
          <img width="100%" :src="addGoodForm.dialogImageUrl" alt="">
        </el-dialog>
      </el-form>
    </el-dialog>

    <!--  编辑商品  -->
    <el-dialog title="更新商品" :visible.sync="updateInfoDialog" width="40%">
      <el-form ref="form" :model="goodInfo" label-width="80px">
        <div style="display: flex">
          <el-form-item label="商品名称">
            <el-input v-model="goodInfo.name"></el-input>
          </el-form-item>
          <el-form-item label="进价">
            <el-input v-model="goodInfo.inPrice"></el-input>
          </el-form-item>
        </div>
        <div style="display: flex">
          <el-form-item label="预售价">
            <el-input v-model="goodInfo.outPrice"></el-input>
          </el-form-item>
          <el-form-item label="折扣">
            <el-input v-model=" goodInfo.discount"></el-input>
          </el-form-item>
        </div>
        <div style="display: flex">
          <el-form-item label="库存">
            <el-input v-model="goodInfo.count"></el-input>
          </el-form-item>
          <el-form-item label="类别">
            <el-cascader clearable :options="search.category" v-model="goodInfo.category.id" :props="{
                      expandTrigger: 'hover',
                      value: 'id',
                      label: 'name',
                      children: 'children'}"></el-cascader>
          </el-form-item>
        </div>
        <div style="display: flex">
          <el-form-item label="上架日期">
            <el-input disabled v-model="(goodInfo.saleDate+' ').substring(0,10)"></el-input>
          </el-form-item>
          <el-form-item label="标题">
            <el-input v-model="goodInfo.title"></el-input>
          </el-form-item>
        </div>
        <div style="display: flex">
          <el-form-item label="规格kg">
            <el-input v-model="goodInfo.weight"></el-input>
          </el-form-item>
          <el-form-item label="产地">
            <el-input v-model="goodInfo.seafoodSource"></el-input>
          </el-form-item>
        </div>
        <el-form-item label="详情">
          <el-input type="textarea" :autosize="{ minRows: 5, maxRows: 50}" v-model="goodInfo.info"></el-input>
        </el-form-item>
        <el-form-item label="图片">
          <el-upload action="" list-type="picture-card" :file-list="goodInfo.pics" accept=".png,.jpg"
                     :on-change="onChangeFile" :http-request="updateGoodInfo" :auto-upload="false">
            <i slot="default" class="el-icon-plus"></i>
            <div slot="file" slot-scope="{file}">
              <img class="el-upload-list__item-thumbnail" :src="basePicUrl+file.name" :alt="file.name">
              <span class="el-upload-list__item-actions">
                <span class="el-upload-list__item-preview" @click="handlePictureCardPreview(file)">
                    <i class="el-icon-zoom-in"></i>
                </span>
                <span class="el-upload-list__item-delete" @click="handleRemove2(file)">
                  <i class="el-icon-delete"></i>
                </span>
              </span>
            </div>
          </el-upload>
        </el-form-item>
        <el-form-item>
          <el-button type="primary" @click="updateGoodInfo">更改</el-button>
        </el-form-item>
      </el-form>
    </el-dialog>

    <!--  上传Excel文件筐  -->
    <el-dialog title="批量上传" :visible.sync="batchFileDialog" width="30%">
      <el-upload
        accept=".xlsx,.xls"
        :http-request="batchAddGood"
        :on-change="onChangeBatchFile"
        :auto-upload="false"
        action="">
        <el-button type="success">选择文件</el-button>
      </el-upload>
      <el-button style="margin-top: 20px" type="primary" @click="batchAddGood">上传</el-button>
    </el-dialog>

  </div>
</template>

<script>
import * as good from "../../../network/admin/good/goods"
import * as category from '../../../network/admin/category/category'
import axios from 'axios'

export default {
  name: "goods",
  data() {
    let discountValid = (rule, val, callback) => {
      if (val > 1 && val < 0) {
        return callback(new Error("折扣必须在0-1"));
      } else {
        callback();
      }
    };
    return {
      myHeaders: {Authorization: window.localStorage.getItem("token")},
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
        category: {},
        pics: []
      },
      goodInfoDialog: false,
      addGoodFormDialog: false,
      addGoodForm: {
        name: "",
        inPince: 0,
        outPrice: 0,
        discount: 0,
        count: 0,
        category: "",
        saleDate: null,
        title: "",
        info: "",
        stepActive: 0,
        smallPic: false,
        pics: [],
        dialogImageUrl: "",
        weight:0,
        seafoodSource:"",
      },
      addGoodFormRules: {
        name: [
          {required: true, message: '请输入商品名称', trigger: 'blur'},
          {max: 30, message: '长度在 30 个字符以内', trigger: 'blur'}
        ],
        inPince: [
          {required: true, message: '请输入商品进价', trigger: 'blur'},
          {type: 'number', message: '价格必须为数字值'}
        ],
        outPrice: [
          {required: true, message: '请输入商品预售价', trigger: 'blur'},
          {type: 'number', message: '价格为数字值'}
        ],
        discount: [
          {required: true, message: '请输入商品折扣', trigger: 'blur'},
          {type: 'number', message: '折扣为数字值', validator: discountValid},
        ],
        count: [
          {required: true, message: '请输入商品进价', trigger: 'blur'},
          {type: 'number', message: '库存为数字值'}
        ],
        category: [
          {required: true, message: '请选择分类', trigger: 'change'}
        ],
        title: [
          {required: true, message: '请输入商品标题', trigger: 'blur'},
          {max: 40, message: '长度在 40 个字符以内', trigger: 'blur'}
        ],
        info: [
          {required: true, message: '请输入商品标题', trigger: 'blur'},
          {max: 300, message: '长度在 300 个字符以内', trigger: 'blur'}
        ],
        weight:[
          {required: true, message: '请输入商品规格', trigger: 'blur'},
          {type: 'number', message: '商品规格为数字值'}
        ],
        seafoodSource: [
          {required: true, message: '请输入商品产地', trigger: 'blur'},
          {max: 12, message: '长度在 12 个字符以内', trigger: 'blur'}
        ]
      },
      fileList: [],
      upFileList: [],
      basePicUrl: good.pic_url,
      updateInfoDialog: false,
      updateGoodInfoId: "",
      batchFileList:[],
      batchFileDialog:false,
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
    toSecondPic(formName) {
      this.$refs[formName].validate((valid) => {
        if (valid) {
          this.addGoodForm.stepActive = 1;
        } else {
          return false;
        }
      });
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
    //添加商品模态框关闭时调用
    addGoodFormDialogClose() {
      this.addGoodForm.stepActive = 0;
    },
    //添加单个商品
    addGood() {
      //上传文件
      for (let i = 0; i < this.upFileList.length; i++) {
        let formData = new FormData()
        formData.append('file', this.upFileList[i])
        this.$axios.post("http://127.0.0.1:9527/admin/uploadGoodPic", formData, {
          headers: {
            'Content-Type': 'multipart/form-data',
            'Authorization': window.localStorage.getItem('token')
          }
        }).then(res => {
          console.log(res);
        })
      }

      for (let i = 0; i < this.upFileList.length; i++) {
        //添加海鲜产品
        good.addGood(this.addGoodForm.name, this.addGoodForm.inPince, this.addGoodForm.outPrice, this.addGoodForm.count,
          this.addGoodForm.discount, this.addGoodForm.category[1], this.addGoodForm.title, this.addGoodForm.info, this.upFileList[i].name,
        this.addGoodForm.weight, this.addGoodForm.seafoodSource).then(res => {
          if (res.data.code == 200) {
            this.$notify.success(res.data.message);
          }
        }).catch(err => {
          console.log(err)
        })
      }
      this.addGoodFormDialog = false;
      this.addGoodForm = {}
    },
    onChangeFile(file, fileList) {
      this.upFileList = []
      const name = file.name.split('.')[1]
      for (let x of fileList) {
        if (x.raw) {
          this.upFileList.push(x.raw)
        }
      }
    },
    //获取更新商品详情
    updateGoodInfoShow(row) {
      this.updateGoodInfoId = row.id;
      good.getSeafoodById(row.id).then(res => {
        this.goodInfo = res.data.data;
        this.updateInfoDialog = true;
      }).catch(err => {
        console.log(err);
      })
    },
    updateGoodInfo() {
      //重新上传文件
      for (let i = 0; i < this.upFileList.length; i++) {
        let formData = new FormData()
        formData.append('file', this.upFileList[i])
        this.$axios.post("http://127.0.0.1:9527/admin/uploadGoodPic", formData, {
          headers: {
            'Content-Type': 'multipart/form-data',
            'Authorization': window.localStorage.getItem('token')
          }
        }).then(res => {
          console.log(res);
        }).catch(err => {
          console.log(err)
        })
      }
      //上传的文件与商品添加关联，更新商品
      for (let i = 0; i < this.upFileList.length; i++) {
        good.updateGood(this.updateGoodInfoId, this.goodInfo.name, this.goodInfo.inPrice, this.goodInfo.outPrice, this.goodInfo.count,
          this.goodInfo.discount, (this.goodInfo.category.id + "").indexOf(",") == -1 ? this.goodInfo.category.id : this.goodInfo.category.id[1], this.goodInfo.title, this.goodInfo.info, this.upFileList[i].name,
        this.goodInfo.weight,this.goodInfo.seafoodSource).then(res => {
          if (res.data.code == 200) {
            this.$notify.success(res.data.message);
          }
        }).catch(err => {
          console.log(err)
        })
      }
      if (this.upFileList.length <= 0) {
        good.updateGood(this.updateGoodInfoId, this.goodInfo.name, this.goodInfo.inPrice, this.goodInfo.outPrice, this.goodInfo.count,
          this.goodInfo.discount, (this.goodInfo.category.id + "").indexOf(",") == -1 ? this.goodInfo.category.id : this.goodInfo.category.id[1], this.goodInfo.title, this.goodInfo.info, null,
          this.goodInfo.weight,this.goodInfo.seafoodSource).then(res => {
          if (res.data.code == 200) {
            this.$notify.success(res.data.message);
          }
        }).catch(err => {
          console.log(err)
        })
      }
      this.getCategory();
      this.getAllGoods();
      this.updateInfoDialog = false;
    },
    //更新商品时删除图片
    handleRemove2(file) {
      //删除图片
      good.deleteSeafoodPic(this.updateGoodInfoId, file.name).then(res => {
        if (res.data.code == 200){
          this.$notify.success(res.data.message);
          good.getSeafoodById(this.updateGoodInfoId).then(res2=>{
            if (res2.data.data.pics.length > 0){
              for (let i = 0; i < res2.data.data.pics.length; i++) {
                this.goodInfo.pics.splice(0,this.goodInfo.pics.length,res2.data.data.pics[i])
              }
            }else {
              this.goodInfo.pics.splice(0,this.goodInfo.pics.length)
            }
          })
        }
      }).catch(err => {
        console.log(err)
      })
    },
    //删除商品
    deleteGood(row){
      this.$confirm("确认删除名为" + row.name + "的商品吗", '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(yes=>{
        good.deleteSeafood(row.id).then(res=>{
          if (res.data.code == 200){
            this.$notify.success(res.data.message);
            this.getAllGoods();
          }
        })
      }).catch(no=>{
        this.$notify.warning("已经取消删除")
      })

    },
    downExcel(){
      window.location.href = "http://localhost:8888/files/批量插入模板.xlsx";
    },
    onChangeBatchFile(file,fileList){
      this.batchFileList = []
      const name = file.name.split('.')[1]
      for (let x of fileList) {
        if (x.raw) {
          this.batchFileList.push(x.raw)
        }
      }
    },
    batchAddGood(){
      for (let i = 0; i < this.batchFileList.length; i++) {
        let formData = new FormData()
        formData.append('file', this.batchFileList[i])
        this.$axios.post("http://127.0.0.1:9527/admin/uploadExcel", formData, {
          headers: {
            'Content-Type': 'multipart/form-data',
            'Authorization': window.localStorage.getItem('token')
          }
        }).then(res => {
          console.log(res);
          this.$notify.success(res.data.message);
          this.batchFileDialog = false;
        })
      }

    }
  }
}
</script>

<style scoped>
.my-search-input {
  width: 8%;
}
a{
  text-decoration: none;
}
</style>
