<template>
  <div>
    <el-breadcrumb separator="/">
      <el-breadcrumb-item>当前位置:</el-breadcrumb-item>
      <el-breadcrumb-item>产品管理</el-breadcrumb-item>
      <el-breadcrumb-item>商品分类</el-breadcrumb-item>
    </el-breadcrumb>
    <el-card style="margin-top: 15px;">
      <el-button type="primary" @click="addCategoryDialogShow = true" size="mini">新增分类</el-button>
      <!--      表格-->
      <el-table
        :data="categoryList"
        style="width: 100%;margin-top: 10px;"
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
          prop="categoryDesc"
          label="描述">
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
          label="操作">
          <template slot-scope="scope">
            <el-button size="mini" type="primary" icon="el-icon-edit" @click="toUpdate(scope.row)">修改</el-button>
            <el-button size="mini" type="danger" icon="el-icon-delete" @click="deleteCategory(scope.row)">删除</el-button>
          </template>
        </el-table-column>
      </el-table>
    </el-card>

    <!-- 增加商品分类弹出框-->
    <el-dialog
      title="增加商品分类"
      :visible.sync="addCategoryDialogShow"
      width="30%">
      <el-tabs v-model="activeName" type="card">
        <el-tab-pane label="一级分类" name="first">
          <!-- 一级权限         -->
          <el-form ref="firstForm" :model="firstForm" label-width="80px" :rules="firstRules">
            <el-form-item label="分类名称" prop="name">
              <el-input v-model="firstForm.name" required></el-input>
            </el-form-item>
            <el-form-item label="分类描述" prop="desc">
              <el-input v-model="firstForm.desc" required></el-input>
            </el-form-item>
            <el-form-item>
              <el-button type="primary" @click="addForm1('firstForm')">增加</el-button>
            </el-form-item>
          </el-form>
        </el-tab-pane>
        <el-tab-pane label="二级分类" name="second">
          <!-- 二级权限         -->
          <el-form ref="secondForm" :model="secondForm" label-width="80px" :rules="firstRules">
            <el-form-item label="分类名称" prop="name">
              <el-input v-model="secondForm.name"></el-input>
            </el-form-item>
            <el-form-item label="分类描述" prop="categoryDesc">
              <el-input v-model="secondForm.desc"></el-input>
            </el-form-item>
            <el-form-item label="父级分类" prop="parent">
              <el-select v-model="secondForm.parent" placeholder="请选择">
                <el-option
                  v-for="item in categoryList"
                  :key="item.id"
                  :label="item.name"
                  :value="item.id">
                </el-option>
              </el-select>
            </el-form-item>
            <el-form-item>
              <el-button type="primary" @click="addForm2('secondForm')">增加</el-button>
            </el-form-item>
          </el-form>
        </el-tab-pane>
      </el-tabs>
    </el-dialog>


    <!--  修改  -->
    <el-dialog title="修改分类" :visible.sync="dialogUpdate" width="30%">
      <el-form ref="updateForm" :model="updateForm" label-width="80px">
        <el-form-item label="名称" prop="name">
          <el-input v-model="updateForm.name"></el-input>
        </el-form-item>
        <el-form-item label="等级" prop="level">
          <el-radio-group v-model="updateForm.level" size="small" fill="#66b1ff" disabled>
            <el-radio-button :label="1">一级</el-radio-button>
            <el-radio-button :label="2">二级</el-radio-button>
          </el-radio-group>
        </el-form-item>
        <el-form-item label="描述" prop="name">
          <el-input v-model="updateForm.categoryDesc"></el-input>
        </el-form-item>
        <el-form-item label="父分类" prop="parent" v-if="updateForm.level == 2">
          <el-select v-model="updateForm.parent" placeholder="请选择">
            <el-option
              v-for="item in categoryList"
              :key="item.id"
              :label="item.name"
              :value="item.id">
            </el-option>
          </el-select>
        </el-form-item>
      </el-form>
      <span slot="footer" class="dialog-footer">
    <el-button type="primary" @click="updateCategory">确认修改</el-button>
  </span>
    </el-dialog>
  </div>
</template>

<script>
import * as category from '../../../network/admin/category/category'

export default {
  name: "category",
  data() {
    return {
      categoryList: [],
      addCategoryDialogShow: false,
      activeName: 'first',
      firstForm: {
        name: "",
        desc: ""
      },
      secondForm: {
        name: "",
        desc: "",
        parent: null
      },
      firstRules: {
        name: [
          {required: true, message: '请输入权限名称', trigger: 'blur'},
        ],
        desc: [
          {required: true, message: '请填写图标代码', trigger: 'blur'}
        ],
        parent: [
          {required: true, message: '请选择父级权限', trigger: 'change'}
        ],
      },
      dialogUpdate:false,
      updateForm:{}
    }
  },
  mounted() {
    this.getCategory();
  },
  methods: {
    //获取所有分类
    getCategory() {
      category.getAllCategory().then(res => {
        if (res.data.code == 200) {
          this.categoryList = res.data.data;
        }
      }).catch(err => {
        console.log(err);
      })
    },
    //添加一级目录
    addForm1(val) {
      this.$refs[val].validate((valid => {
        if (valid) {
          //通过验证可以提交
          category.addCategory(this.firstForm.name, this.firstForm.desc, null).then(res => {
            if (res.data.code == 200) {
              this.$notify.success(res.data.message);
              this.addCategoryDialogShow = false;
              this.getCategory();
            }
          })
        }
      }))

    },
    //添加二级分类
    addForm2(val) {
      this.$refs[val].validate((valid => {
        if (valid) {
          //通过验证可以提交
          category.addCategory(this.secondForm.name, this.secondForm.desc, this.secondForm.parent).then(res => {
            if (res.data.code == 200) {
              this.$notify.success(res.data.message);
              this.addCategoryDialogShow = false;
              this.getCategory();
            }
          })
        }
      }))
    },
    deleteCategory(row) {
      this.$confirm("确认删除名称为 " + row.name + " 的分类吗", '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        category.deleteCategory(row.id).then(res => {
          if (res.data.code == 200) {
            this.$notify.success(res.data.message);
            this.getCategory();
          } else {
            this.$notify.error(res.data.message);
          }
        })
      }).catch(()=>{
        this.$notify.success("成功取消删除")
      })
    },
    toUpdate(row){
      category.getCategoryById(row.id).then(res => {
        this.updateForm.id = row.id;
        this.updateForm = res.data.data;
        this.getCategory();
        this.dialogUpdate = true;
      })
    },
    updateCategory(){
      //把修改表单提交到后台处理
      category.updateCategory(this.updateForm).then(res => {
        if (res.data.code == 200){
          this.$notify.success(res.data.message)
        }else if(res.data.code == 444){
          this.$notify.error(res.data.message)
        }
        this.dialogUpdate = false;
        this.getCategory();
      })
    }
  }
}
</script>

<style scoped>

</style>
