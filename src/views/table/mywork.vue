<template>
<div>
  <el-table
    :data="tableData"
    style="width: 100%"
    :row-class-name="tableRowClassName">
    <el-table-column align="center"  
      prop="ID"
      label="序号"
      width="180">
    </el-table-column>
    <el-table-column align="center"
      prop="title"
      label="任务名"
      width="180">
    </el-table-column>
    <el-table-column align="center"
      prop="author"
      label="当前负责人">
    </el-table-column>
    <el-table-column align="center"
      prop="status"
      label="进度">
    </el-table-column>
    <el-table-column align="center"
      prop="address"
      label="操作">
      <template slot-scope="scope">
          <el-button size="mini"  type="primary"  @click="opendialog(scope.$index, scope.row.ID)">处理</el-button>
          <el-button v-if="scope.row.status ='published'"  size="mini"  type="success"  @click="handleModifyStatus(scope.row,'published')">提交</el-button>
          <el-button v-else size="mini" @click="handleModifyStatus(scope.row,'draft')">取回</el-button>
        </template>
    </el-table-column>
  </el-table>
<el-dialog title="任务详情" :visible.sync="dialogMyqVisible"  >
  <myQ ref="Q1" :list="listQuery2" :lis="liswork" :checkQuery="checkwork" :AskQuery="Askwork">
  </myQ>
</el-dialog >
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
  import myQ from '@/components/Options.vue'
  import axios from 'axios'
  export default {
    data() {
      return {
        geturl : 'http://127.0.0.1:3000/getques',
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
    components: { myQ },
    created() {
      this.fetchData(this.geturl)
    },
    methods: {
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
            console.log(response.data[0])
            self.tableData = response.data
            console.log(self.tableData)
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
        this.queindex = index
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
            self.dialogMyqVisible2 = true
            self.dialogMyqVisible = true
          })
    }
  }
  }
</script>