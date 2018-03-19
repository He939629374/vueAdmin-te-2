<template>
  <div class="app-container ">
    <div class="filter-container" style="padding-bottom:10px">
      <el-input @keyup.enter.native="handleFilter" style="width: 200px;" class="filter-item"  v-model="listQuery.title" placeholder="任务名称">
      </el-input>
      <el-select clearable style="width: 110px" class="filter-item" v-model="listQuery.status" placeholder="状态">
        <el-option v-for="item in statusOptions" :key="item" :label="item" :value="item" >
        </el-option>
      </el-select>
      <el-select clearable class="filter-item" style="width: 130px" v-model="listQuery.pageviews" placeholder="考察点">
        <el-option v-for="item in  pageviewsOptions" :key="item" :label="item" :value="item">
        </el-option>
      </el-select>
      <el-select @change='handleFilter' style="width: 140px" class="filter-item" v-model="listQuery.sort" placeholder="ID">
        <el-option v-for="item in sortOptions" :key="item.key" :label="item.label" :value="item.key">
        </el-option>
      </el-select>
      <el-button class="filter-item" type="primary"  icon="el-icon-search" @click="handleFilter">搜索</el-button>
      <el-button class="filter-item" style="margin-left: 10px;" @click="handleCreate" type="primary" icon="el-icon-edit">添加</el-button>
      <el-button class="filter-item" style="margin-left: 10px;" @click="handleDelay" type="primary" icon="el-icon-edit">删除</el-button>
    </div>

    <el-table  :data="list" v-loading.body="listLoading" element-loading-text="Loading"  
    border fit highlight-current-row
     @current-change="handleCurrentChange1"  >
     <el-table-column
      type="selection"
      width="45"
      >
    </el-table-column>
      <el-table-column align="center" label='ID' width="95" >
        <template slot-scope="scope" >
          {{scope.$index+1}}
        </template>
      </el-table-column>
      <el-table-column align="center" prop="created_at" label="开始时间" width="200">
        <template slot-scope="scope">
          <i class="el-icon-time"></i>
          <span>{{scope.row.display_time}}</span>
        </template>
      </el-table-column>
      <el-table-column label="任务名" min-width="150px">
        <template slot-scope="scope">
          <span class="link-type" @click="handleEdit(scope.$index,scope.row)">{{scope.row.title}}</span>
        </template>
      </el-table-column>
      <el-table-column label="处理人" width="110" align="center">
        <template slot-scope="scope">
          <span>{{scope.row.author}}</span>
        </template>
      </el-table-column>
      <el-table-column label="考察点" width="110" align="center">
        <template slot-scope="scope">
          {{scope.row.pageviews}}
        </template>
      </el-table-column>
      <el-table-column class-name="status-col" label="处理状态" width="110" align="center">
        <template slot-scope="scope">
          <el-tag :type="scope.row.status | statusFilter">{{scope.row.status}}</el-tag>
        </template>
      </el-table-column>
      <el-table-column align="center" label="操作" width="230" class-name="small-padding fixed-width">
        <template slot-scope="scope">
          <el-button size="mini"  type="primary"  @click="handleEdit(scope.$index, scope.row)">编辑</el-button>
          <el-button v-if="scope.row.status !='published'"  size="mini"  type="success"  @click="handleModifyStatus(scope.row,'published')">发布</el-button>
          <el-button v-if="scope.row.status !='draft'" size="mini" @click="handleModifyStatus(scope.row,'draft')">取回</el-button>
          <el-button v-if="scope.row.status !='deleted'" type="danger" size="mini" @click="handleModifyStatus(scope.row,'deleted')">删除</el-button>
        </template>
       </el-table-column>
    </el-table>
   <div class="pagination-container">
      <el-pagination background @size-change="handleSizeChange" @current-change="handleCurrentChange" :current-page.sync="listQuery.page"
        :page-sizes="[10,20,30, 50]" :page-size="listQuery.limit" layout="total, sizes, prev, pager, next, jumper" :total="total">
   </el-pagination>
    </div>
<el-dialog title="详情" :visible.sync="dialogTableVisible">
  <el-form ref="dataForm" :model="temp" label-position="left" label-width="70px" style='width: 400px; margin-left:50px;'>
    <el-form-item label="任务名">
      <el-input v-model="temp.title" placeholder="请填写任务名称"></el-input>
    </el-form-item>
    <el-form-item label="处理人">
      <el-input v-model="temp.author" placeholder="请填写处理人"></el-input>
</el-form-item>
    <el-form-item label="考察点">
      <el-select v-model="temp.pageviews" placeholder="请选择考察点">
        <el-option v-for="item in  pageviewsOptions" :key="item" :label="item" :value="item">
        </el-option>
      </el-select>
    </el-form-item>
    <el-form-item label="状态">
      <el-select v-model="temp.status" placeholder="请选择当前状态">
        <el-option v-for="item in  statusOptions" :key="item" :label="item" :value="item">
        </el-option>
      </el-select>
    </el-form-item>
    <el-form-item label="开始时间">
      <el-date-picker v-model="temp.display_time" type="date" placeholder="请选择开始时间">
      </el-date-picker>
    </el-form-item>
  </el-form>
  <div slot="footer" class="dialog-footer">
        <el-button @click="dialogTableVisible = false">取消</el-button>
        <el-button v-if="dialogStatus=='create'" type="primary" @click="createData">新增</el-button>
        <el-button v-else type="primary" @click="updateData">确定</el-button>
  </div>
</el-dialog>
  </div>
</template>

<script>
// import { getList } from '@/api/table'
import axios from 'axios'
// const ValID = ''
export default {
  data() {
    return {
      temp: {
        // id: undefined,
        // importance: 1,
        ID: '',
        author: '',
        pageviews: '',
        display_time: '',
        title: '',
        status: ''
      },
      listQuery: {
        page: 1,
        limit: 20,
        status: '',
        title: '',
        pageviews: '',
        sort: ''
      },
      sortOptions: {},
      pageviewsOptions: ['南海', '禅城', '顺德'],
      statusOptions: ['published', 'draft', 'deleted'],
      dialogTableVisible: false,
      dialogStatus: '',
      list: null,
      listLoading: true,
      total: null
    }
  },
  filters: {
    statusFilter(status) {
      const statusMap = {
        published: 'success',
        draft: 'info',
        deleted: 'danger'
      }
      return statusMap[status]
    }
  },
  created() {
    this.fetchData()
  },
  methods: {
    fetchData() {
      this.listLoading = true
      var self = this
      axios.get('http://127.0.0.1:3000/list' + '?limit=' + this.listQuery.limit)
        .then(function(response) {
          console.log(response.data[0][0].ID)
          console.log(response.data[1])
          self.total = response.data[1][0].len
          // self.list = [].concat.apply([], response.data)
          self.list = response.data[0]
          // console.log(self.list)
          self.listLoading = false
        }).catch(function(error) {
          console.log(error)
        })
    },
    searchData() {
      this.listLoading = true
      var self = this
      axios.get('http://127.0.0.1:3000/search' + '?limit=' +
        this.listQuery.limit + '&status=' +
        this.listQuery.status + '&title=' +
        this.listQuery.title + '&pageviews=' +
        this.listQuery.pageviews)
        .then(function(response) {
          console.log(response.data[0][0].ID)
          console.log(response.data[1])
          self.total = response.data[1][0].len
          // self.list = [].concat.apply([], response.data)
          self.list = response.data[0]
          // console.log(self.list)
          self.listLoading = false
        }).catch(function(error) {
          console.log(error)
          self.listLoading = false
        })
    },
    handleFilter() {
      this.listQuery.page = 1
      this.searchData()
    },
    handleSizeChange(val) {
      if (this.listQuery.limit === val) {
        return
      }
      this.listQuery.limit = val
      this.fetchData()
    },
    handleCurrentChange(val) {
      if (this.listQuery.page === val) {
        return
      }
      this.listQuery.page = val
      this.fetchData()
    },
    handleCurrentChange1(val) {
      this.ValID = val.ID
      console.log(this.ValID)
    },
    resetTemp() {
      this.temp = {
        ID: '',
        author: undefined,
        pageviews: '南海',
        display_time: new Date(),
        title: '',
        status: 'published'
      }
    },
    handleCreate() {
      this.resetTemp()
      this.dialogStatus = 'create'
      this.dialogTableVisible = true
      this.$nextTick(() => {
        this.$refs['dataForm'].clearValidate()
      })
    },
    handleDelay() {
      // this.dialogTableVisible = true
      this.DelayData()
    },
    DelayData() {
      var self = this
      var qs = require('qs') // 处理post内容格式
      alert(self.ValID)
      axios.post('http://127.0.0.1:3000/delList', qs.stringify({
        id: self.ValID
      }))
        .then(function(response) {
          console.log(response.data[0])
          self.fetchData()
          self.listLoading = false
        }).catch(function(error) {
          console.log(error)
        })
      this.dialogTableVisible = false // loading层关闭
      this.$notify({
        title: '成功',
        message: '删除成功',
        type: 'success',
        duration: 2000
      })
    },
    createData() {
      this.$refs['dataForm'].validate((valid) => {
        var self = this
        if (valid) {
          const tempData = Object.assign({}, this.temp) // 复制当前所选内容
          const DTime = self.moment(tempData.display_time).format('YYYY-MM-DD') // 处理日期格式
          var qs = require('qs') // 处理post内容格式
          axios.post('http://127.0.0.1:3000/addlist', qs.stringify({
            author: tempData.author,
            pageviews: tempData.pageviews,
            display_time: DTime,
            title: tempData.title,
            status: tempData.status,
            id: tempData.ID
          }))
            .then(function(response) {
              console.log(response.data[0])
              self.dialogTableVisible = false // 关闭新增页面
              self.fetchData()
              self.listLoading = false
            }).catch(function(error) {
              console.log(error)
            })
          this.$notify({
            title: '成功',
            message: '新增成功',
            type: 'success',
            duration: 2000
          })
        }
      })
    },
    handleModifyStatus(row, status) {
      console.log(row.status)
      console.log(status)
      this.$message({
        message: '操作成功',
        type: 'success'
      })
      row.status = status
    },
    handleEdit(index, row) {
      console.log(row.ID)
      this.temp = Object.assign({}, row) // copy obj
      this.dialogTableVisible = true
      this.dialogStatus = 'updata'
      this.$nextTick(() => {
        this.$refs['dataForm'].clearValidate()
      })
    },
    updateData() {
      this.$refs['dataForm'].validate((valid) => {
        this.dialogTableVisible = true
        var self = this
        if (valid) {
          const tempData = Object.assign({}, this.temp) // 复制当前所选内容
          const DTime = self.moment(tempData.display_time).format('YYYY-MM-DD') // 处理日期格式
          var qs = require('qs') // 处理post内容格式
          axios.post('http://127.0.0.1:3000/uplist', qs.stringify({
            author: tempData.author,
            pageviews: tempData.pageviews,
            display_time: DTime,
            title: tempData.title,
            status: tempData.status,
            id: tempData.ID
          }), { headers: { 'content-type': 'application/x-www-form-urlencoded' }})
            .then(function(response) {
              console.log(response.data[0])
              self.fetchData()
              self.listLoading = false
            }).catch(function(error) {
              console.log(error)
            })
          this.dialogTableVisible = false // loading层关闭
          this.$notify({
            title: '成功',
            message: '更新成功',
            type: 'success',
            duration: 2000
          })
        }
      })
    }
    // updateData() {
    //   this.$refs['dataForm'].validate((valid) => {
    //     if (valid) {
    //       const tempData = Object.assign({}, this.temp)
    //       updateArticle(tempData).then(() => {
    //         for (const v of this.list) {
    //           if (v.id === this.temp.id) {
    //             const index = this.list.indexOf(v)
    //             this.list.splice(index, 1, this.temp)
    //             break
    //           }
    //         }
    //         this.dialogTableVisible = false
    //         this.$notify({
    //           title: '成功',
    //           message: '更新成功',
    //           type: 'success',
    //           duration: 2000
    //         })
    //       })
    //     }
    //   })
    // },
  }
}
</script>
