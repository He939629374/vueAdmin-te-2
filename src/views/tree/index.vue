<template>
<div>
  <el-table
  v-loading.body="listLoading"
    :data="tableData"
    style="width: 100%"
    :row-class-name="tableRowClassName">
    <el-table-column align="center"  
      prop="ID"
      label="用户ID"
      min-width="180">
    </el-table-column>
    <el-table-column align="center"
      label="用户名"
      min-width="180">
      <template slot-scope="scope">
          <span class="link-type" @click="opendialog(scope.$index, scope.row.ID)">{{scope.row.user_name}}</span>
      </template>
    </el-table-column>
    <el-table-column align="center"
      prop="password"
      label="密码"
      min-width="180">
    </el-table-column>
    <el-table-column align="center"
      prop="permission"
      label="权限"
      min-width="180">
    </el-table-column>
      <el-table-column align="center" label="操作" min-width="180" class-name="small-padding fixed-width">
        <template slot-scope="scope">
          <el-button size="mini" v-if="status===true" type="primary"  @click="handleEdit(scope.$index, scope.row)">编辑</el-button>
          <el-button v-else  size="mini"  type="success" @click="status =!status">完成</el-button>
          <el-button type="danger" size="mini" >删除</el-button>
        </template>
       </el-table-column>
  </el-table>

</div>
</template>

<style>
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
        listLoading:false,
        alllist:[],
        inputwork:false,
        iswork:false,
        geturl : 'http://127.0.0.1:3000/getper',
        handleurl: 'http://127.0.0.1:3000/gethandle',
        dialogMyqVisible: false,
        status:true, //true创建 false保存
        queindex: '',
        tableData:[],
      listQuery2: [],
      liswork: [],
      checkwork: [],
      Askwork: []
      }
    },
    components: {  },
    filters: {
    },
    created() {
      this.fetchData(this.geturl)
    },
    methods: {
        handleEdit(index, row) {
          console.log(row)
          this.status = false
          this.temp = Object.assign({}, row) // copy obj

          this.$nextTick(() => {
            //this.$refs['dataForm'].clearValidate()
          })
        },
        tableRowClassName({row, rowIndex}) {
          if (rowIndex === 1) {
            return 'warning-row';
          } else if (rowIndex === 3) {
            return 'success-row';
          }
          return '';
        },
        fetchData(url) {
        this.listLoading = true
        var self = this
        axios.get(url)
            .then(function(response) {
            self.tableData = Object.assign({}, response.data) 
            for(var i=0; i++; i<response.data.length){
              self.tableData[i].push({'status':true})
            }
            console.log(self.tableData[0])
            self.listLoading = false
            }).catch(function(error) {
            console.log(error)
            })
        },
      opendialog(index,ID) {
        this.listQuery2=[]
        this.liswork=[]
        this.checkwork=[]
        this.Askwork=[]
        console.log(index)
        var self = this
        this.queindex = ID
        axios.get('http://127.0.0.1:3000/gethandle' + '?ID=' + ID)
          .then(function(response) {
            console.log(response.data)   
            for(var i=0;i<response.data.length;i++){
              if (response.data[i].type == 0) {
                  self.listQuery2.push(response.data[i])
              } else if (response.data[i].type == 1) {
                  self.liswork.push(response.data[i])
              } else if (response.data[i].type == 2) {
                response.data[i].ceck = response.data[i].ceck.split(",")
                response.data[i].radio = response.data[i].radio.split(",")
                self.checkwork.push(response.data[i])
                console.log(self.checkwork)   
              } else if (response.data[i].type == 3) {
                self.Askwork.push(response.data[i])
              } else {
              }
            }
            self.dialogMyqVisible = true
          })
    }
  }
  }
</script>