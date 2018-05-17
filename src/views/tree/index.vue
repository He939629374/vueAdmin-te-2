<template>
<div class="app-container calendar-list-container">
    <div class="filter-container" style="padding-bottom:10px;text-align:left;margin-left:30px;width:100%">
      <el-select clearable class="filter-item" style="width: 100px" v-model="value" placeholder="请选择">
        <el-option
          v-for="item in options"
          :key="item.value"
          :label="item.label"
          :value="item.value">
        </el-option>
      </el-select>
      <el-input  class="filter-item" style="width: 130px" v-model="invalue" @keyup.13.native="selper"></el-input>
      <el-button class="filter-item" type="primary"  icon="el-icon-search" @click="selper" >搜索</el-button>
      <el-button class="filter-item" style="margin-left: 10px;"  type="primary" icon="el-icon-edit" @click="dialogFormVisible = true">添加</el-button>
    </div>
<el-dialog title="用户添加" :visible.sync="dialogFormVisible" style="text-align:left;" width="400px">
  <el-form :model="form">
    <el-form-item label="用户名" :label-width="formLabelWidth">
      <el-input v-model="form.user_name" auto-complete="off" autofocus='true'></el-input>
    </el-form-item>
    <el-form-item label="密码" :label-width="formLabelWidth">
      <el-input v-model="form.password" auto-complete="off"></el-input>
    </el-form-item>
    <el-form-item label="账号权限" :label-width="formLabelWidth">
      <el-select v-model="form.permission" placeholder="请选择账号类型">
        <el-option label="管理账号" value="0"></el-option>
        <el-option label="一般账号" value="1"></el-option>
      </el-select>
    </el-form-item>
  </el-form>
  <div slot="footer" class="dialog-footer">
    <el-button @click="dialogFormVisible = false">取 消</el-button>
    <el-button type="primary" @click="AddEdit">确 定</el-button>
  </div>
</el-dialog>
  <el-table
  v-loading.body="listLoading"
    :data="tableData"
    border fit highlight-current-row style="width: 100%">
    <el-table-column align="center"  
      prop="ID"
      label="用户ID"
      width="80">
    </el-table-column>
    <el-table-column align="center"
      label="用户名"
      min-width="180">
      <template slot-scope="scope">
        <template v-if="!scope.row.status">
          <el-input class="edit-input" style="width:150px" min-width="60" autofocus='true'  size="mini" v-model="scope.row.user_name"></el-input>
        </template>
        <span v-else>{{ scope.row.user_name }}</span>
      </template>
    </el-table-column>
    <el-table-column align="center" label="密码" min-width="180" >
      <template slot-scope="scope">
        <template v-if="!scope.row.status">
          <el-input class="edit-input" style="width:120px" min-width="60"  autofocus='true'  size="mini" v-model="scope.row.password"></el-input>
        </template>
        <span v-else>{{ scope.row.password }}</span>
      </template>
    </el-table-column>
    <el-table-column min-width="180" label="权限" align="center">
      <template slot-scope="scope">
        <template v-if="!scope.row.status">
          <el-input class="edit-input" min-width="60" autofocus='true'  size="mini" v-model="scope.row.permission"></el-input>
          <el-button class='cancel-btn' size="small" type="warning" @click="cancelEdit(scope.$index, scope.row)">取消</el-button>
        </template>
        <span v-else>{{ scope.row.permission }}</span>
      </template>
    </el-table-column>
      <el-table-column align="center" label="操作" min-width="180" class-name="small-padding fixed-width">
        <template slot-scope="scope">
          <el-button size="mini" v-if="scope.row.status===true" type="primary"  @click="firstEdit(scope.$index, scope.row)">编辑</el-button>
          <el-button v-else  size="mini"  type="success" @click="handleEdit(scope.$index, scope.row)">完成</el-button>
          <el-button type="danger" size="mini" @click="DeEdit(scope.$index, scope.row)">删除</el-button>
        </template>
       </el-table-column>
  </el-table>

</div>
</template>

<style>
  .edit-input {
    width: 60px
  }
  .cancel-btn {
    position: absolute;
    right: 15px;
    top: 10px;
  }
  .el-table .warning-row {
    background: oldlace;
  }

  .el-table .success-row {
    background: #f0f9eb;
  }
</style>

<script>
  import axios from 'axios'
  export default {
    data() {
      return {
        formLabelWidth:'100px',
        dialogFormVisible:false,
        listLoading:false,
        alllist:[],
        inputwork:false,
        iswork:false,
        geturl : 'http://127.0.0.1:3000/getper',
        upurl:'http://127.0.0.1:3000/upper',
        handleurl: 'http://127.0.0.1:3000/gethandle',
        dialogMyqVisible: false,
        status:true, //true创建 false保存
        queindex: '',
        tableData:[],
        tempper:{
          user_name: '',
          password: '',
          permission: '',
        },
      listQuery: [],
      liswork: [],
      checkwork: [],
      Askwork: [],
      form: {
          user_name: '',
          password: '',
          permission: '',
        },
      options: [{
          value: 'ID',
          label: 'ID'
        },{
          value: 'user_name',
          label: '用户名'
        },{
          value: 'permission',
          label: '权限'
        }],
        value:'',
        invalue:''
      }
    },
    components: {  },
    filters: {
    },
    created() {
      this.fetchData(this.geturl)
    },
    methods: {
      aaa() {
        console.log(this.value)
      },
      AddEdit() {
        var self =this
        this.$message('s')
        console.log(this.form)
        axios.post('http://127.0.0.1:3000/addper', ({
              user_name:self.form.user_name,
              password:self.form.password,
              permission:self.form.permission
            }))
            .then(function(response) {           
              console.log(response.data)
              if(response.data =='exists'){
                self.$message('用户名已存在');
              }else{
                self.tableData = JSON.parse(JSON.stringify(response.data))
                let res = response.data
                for (let i = 0; i < res.length; i++) {
                  self.$set(self.tableData[i],'status',true) 
                }
              }
            }).catch(function(error) {
            self.$message('操作失败,请检查您的网络状态');
            }) 
            this.dialogFormVisible = false
      },
      DeEdit(index, row) {
        var self =this
        axios.post('http://127.0.0.1:3000/delper', ({
              ID:row.ID 
            }))
            .then(function(response) {  
              self.tableData = JSON.parse(JSON.stringify(response.data))
              let res = response.data
              for (let i = 0; i < res.length; i++) {
                self.$set(self.tableData[i],'status',true) 
              }
            console.log(self.tableData)
            self.listLoading = false           
            console.log(response.data)
            }).catch(function(error) {
            console.log(error)
            }) 
      },
      selper() {
        var self =this
        if(this.value ==''&&this.invalue==''){
          this.$message('搜索条件为空');
        }else{
        axios.get('http://127.0.0.1:3000/selper?' + this.value + '=' + this.invalue)
            .then(function(response) {  
              self.tableData = JSON.parse(JSON.stringify(response.data))
              let res = response.data
              for (let i = 0; i < res.length; i++) {
                self.$set(self.tableData[i],'status',true) 
              }
            console.log(self.tableData)
            self.listLoading = false           
            console.log(response.data)
            }).catch(function(error) {
            console.log(error)
            })
        }

      },
      cancelEdit(index, row) {
        row.permission =  this.tempper.permission
        row.password =  this.tempper.password
        row.user_name =  this.tempper.user_name
        row.status = !row.status
      },
        firstEdit(index, row) {
          this.status = false
          this.temp = Object.assign({}, row) // copy obj
          row.status = !row.status
          this.tempper.permission = this.temp.permission
          this.tempper.password = this.temp.password
          this.tempper.user_name = this.temp.user_name
        },
        handleEdit(index, row) {
          this.status = false
          this.temp = Object.assign({}, row) // copy obj
          row.status = !row.status
          //this.tempper = this.temp.permission
          if(this.tempper.permission != this.temp.permission||
          this.tempper.password != this.temp.password||
          this.tempper.user_name != this.temp.user_name){
           axios.post('http://127.0.0.1:3000/upper', ({
              user_name:row.user_name,
              password:row.password,
              permission:row.permission,
              ID:row.ID 
            }))
              .then(function(response) {                            
              console.log(response.data)
              }).catch(function(error) {
              console.log(error)
              })
          } 
        },
        fetchData(url) {
        this.listLoading = true
        var self = this
        axios.get(url)
            .then(function(response) {             
              self.tableData = JSON.parse(JSON.stringify(response.data))
              let res = response.data
              for (let i = 0; i < res.length; i++) {
                self.$set(self.tableData[i],'status',true) 
              }
            console.log(self.tableData)
            self.listLoading = false
            }).catch(function(error) {
            console.log(error)
            })
        }
  }
  }
</script>