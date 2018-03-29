<template>
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
    </el-table-column>
  </el-table>
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
    methods: {
      tableRowClassName({row, rowIndex}) {
        if (rowIndex === 1) {
          return 'warning-row';
        } else if (rowIndex === 3) {
          return 'success-row';
        }
        return '';
      }
    },
    data() {
      return {
        tableData:[]
      }
    },
    created() {
      this.fetchData()
    },
    methods: {
        fetchData() {
        this.listLoading = true
        var self = this
        axios.get('http://127.0.0.1:3000/getques')
            .then(function(response) {
            console.log(response.data[0])
            self.tableData = response.data
            console.log(self.tableData)
            self.listLoading = false
            }).catch(function(error) {
            console.log(error)
            })
        }
    }
  }
</script>