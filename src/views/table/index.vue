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
      <el-input @change='handleFilter' style="width: 140px" class="filter-item" v-model="listQuery.ID" placeholder="ID">
      </el-input>
      <el-button class="filter-item" type="primary"  icon="el-icon-search" @click="handleFilter">搜索</el-button>
      <el-button class="filter-item" style="margin-left: 10px;" @click="handleCreate" type="primary" icon="el-icon-edit">添加</el-button>
      <el-button class="filter-item" style="margin-left: 10px;" @click="handleDelay" type="primary" icon="el-icon-edit">删除</el-button>
    </div>

    <el-table  :data="list" v-loading.body="listLoading" element-loading-text="Loading"  
    border fit highlight-current-row
     @selection-change="handleCurrentChange1"  >
     <el-table-column
      type="selection"
      width="45"
      >
    </el-table-column>
      <el-table-column align="center" label='ID' width="95" >
        <template slot-scope="scope" >
          {{scope.row.ID}}
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
          <span class="link-type" @click="opendialog(scope.$index, scope.row.ID)">{{scope.row.title}}</span>
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
      <el-select v-model="temp.author" placeholder="请填写处理人">
        <el-option v-for="item in  authorOptions" :value="item">
        </el-option>
      </el-select>
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
<el-dialog title="任务详情" :visible.sync="dialogMyqVisible"   :before-close="handleClose">
    <el-cascader
        expand-trigger="hover"
        :options="options"
        v-model="selectedOptions2">
    </el-cascader>
      <el-button class="filter-item" type="primary"  icon="el-icon-search" @click="handleCreate2">新增</el-button>
      <el-button v-if="status" class="filter-item" type="success"  icon="el-icon-upload" @click="handleSave2">提交</el-button>
      <el-button v-else class="filter-item" type="success"  icon="el-icon-circle-ceck-outline" @click="handleSave2">保存</el-button>
      <myQ2 ref="Q1" :list="listQuery2" :lis="liswork" :checkQuery="checkwork" :AskQuery="Askwork" :isdel='iswork' :isinput='inputwork'></myQ2>
  <!-- <myQ2 :qindex="queindex" :status="status"></myQ2> -->
</el-dialog >
<el-dialog title="任务详情" :visible.sync="dialogMyqVisible2"  >
  <myQ2 ref="Q1" :list="listQuery2" :lis="liswork" :checkQuery="checkwork" :AskQuery="Askwork" :isdel='false' :isinput='inputwork'>
  </myQ2>
</el-dialog >
  </div>
</template>

<script>
import myQ from '@/views/table/work.vue'
import myQ2 from '@/components/Options.vue'
import axios from 'axios'
export default {
  data() {
    return {
      ValID:[],
      Valtitle:[],
      alllist:[],
selectedOptions2: [],
        options: [{
          value: '单选',
          label: '单选',
          children: [{
            value: '是否',
            label: '是否'
          }, {
            value: '星级',
            label: '星级'
          }]
        }, {
          value: '多选',
          label: '多选'
        }, {
          value: '填空',
          label: '填空'
        }, {
          value: '上传',
          label: '上传'
        }],
      inputwork:true,
      iswork:true,
      status:true, //true创建 false保存
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
        limit: 10,
        status: '',
        title: '',
        pageviews: '',
        ID: ''
      },
      authorOptions:[],
      pageviewsOptions: ['南海', '禅城', '顺德'],
      statusOptions: ['published', 'draft', 'deleted'],
      dialogTableVisible: false,
      dialogMyqVisible: false,
      dialogMyqVisible2: false,
      dialogStatus: '',
      list: null,
      listLoading: true,
      total: null,
      queindex: '',
        listQuery2: [
          {
            selfid: 0,
            type: '0',
            title: '标题',
            radio: '',
            edit: true, ceck:['']
          }
        ],
        liswork: [
          {
            selfid: 0,
            type: '1',
            title: '标题',
            edit: true,
            radio: '', ceck:['']
          }
        ],
        checkwork: [
          {
            selfid: 0,
            type: '2',
            radio: ['北京'],
            title: '标题',
            ceck: ['上海', '北京', '广州', '深圳'],
            edit: true
          }
        ],
        Askwork: [
          {
            selfid: 0,
            type: '3',
            title: '标题',
            radio: '',
            edit: true, ceck:['']
          }
        ]
    }
  },
  filters: {
    statusFilter(status) {
      const statusMap = {
        'published': 'success',
        'draft': 'info',
        'deleted': 'danger'
      }
      return statusMap[status]
    }
  },
  created() {
    console.log("2")
    this.fetchData()
  },
  components: { myQ, myQ2 },
  methods: {
      handleSave2() {
        //this.listLoading = true
        var self = this
        this.Pushlist(self.Askwork,self.checkwork,self.liswork,self.listQuery2)
        console.log("qindex"+this.queindex)
        console.log(this.alllist)
        var qs = require('qs') // 处理post内容格式
        axios.post('http://127.0.0.1:3000/addques', qs.stringify({
          alllist:self.alllist,
          qindex:self.queindex
        }))
        .then(function(response) {
          self.alllist=[]
          self.listLoading = false
          //self.$router.go(0);
          self.$router.push({
            path:'/example/table',
            query: {
              t: +new Date() //保证每次点击路由的query项都是不一样的，确保会重新刷新view
            }
          })
          self.dialogMyqVisible = false
      // self.$router.push({
      // path:self.$route.fullPath, // 获取当前连接，重新跳转
      // query:{
      // _time:new Date().getTime()/1000  // 时间戳，刷新当前router
      //   }
      // })
        }).catch(function(error) {
          console.log(error)
        })
      },
      handleCreate2() {
        console.log(this.selectedOptions2)
        if (this.selectedOptions2.length > 1) {
          if (this.selectedOptions2[1] == '是否') {
            this.listQuery2.push({ title: 'moren', radio: '', edit: true,type: '0', selfid: this.listQuery2.length+1, ceck:[''] })
          } else {
            this.liswork.push({ title: 'moren', radio: '', edit: true,type: '1', selfid:this.liswork.length+1, ceck:[''] })
          }
        } else if (this.selectedOptions2 == '多选') {
          this.checkwork.push({ title: 'moren',  radio: ['上海'], edit: true, ceck: ['上海', '北京', '广州', '深圳'],type: '2', selfid:this.checkwork+1 })
        } else if (this.selectedOptions2 == '填空') {
          this.Askwork.push({ title: 'moren', radio: '', edit: true,type: '3', selfid:this.Askwork.length+1, ceck:[''] })
        } else {
          this.$message({
            message: '新增类型未指定',
            type: 'warning'
          })
        }
      },
          handleClose(done) {

            done();
     
      },
    fetchData() {
      this.listLoading = true
      var self = this
      axios.get('http://127.0.0.1:3000/list' + '?limit=' + this.listQuery.limit)
        .then(function(response) {
          console.log(response.data)
          self.total = response.data[1][0].len
          // self.list = [].concat.apply([], response.data)
          self.list = response.data[0]
          self.listLoading = false
        }).catch(function(error) {
          console.log(error)
        })
      axios.get('http://127.0.0.1:3000/getper')
        .then(function(response) {
          for(let i =0;i<response.data.length;i++){
            self.authorOptions.push(response.data[i].user_name)
          }         
        }).catch(function(error) {
          console.log(error)
        })
        this.listQuery.page= 1
    },
    searchData() {
      this.listLoading = true
      var self = this
      axios.get('http://127.0.0.1:3000/search' + '?limit=' +
        this.listQuery.limit + '&limit2=' +
        this.listQuery.page + '&status=' +
        this.listQuery.status + '&title=' +
        this.listQuery.title + '&pageviews=' +
        this.listQuery.pageviews +  '&ID=' + 
        this.listQuery.ID )
        .then(function(response) {
          console.log(response.data[0])
          self.total = response.data[1][0].len 
          self.list = response.data[0]
          // console.log(self.list)
          self.listLoading = false
        }).catch(function(error) {
          console.log(error)
          self.listLoading = false
        })
    },
    handleFilter() {
     // this.listQuery.page = 1
      this.searchData()
    },
    handleSizeChange(val) {
      if (this.listQuery.limit === val) {
        return
      }
      console.log("val" +val)
      this.listQuery.limit = val
      this.searchData()
    },
    handleCurrentChange(val) {
      this.listQuery.page = val
      this.searchData()
    },
    handleCurrentChange1(val) { 
      this.ValID = [] 
      this.Valtitle = [] 
      for(let i =0;i<val.length;i++){
        this.ValID.push(val[i].ID)
        this.Valtitle.push(val[i].title)     
      } 
    },
    resetTemp() {
      this.temp = {
        ID: '',
        author: undefined,
        pageviews: '南海',
        display_time: new Date(),
        title: '',
        status: 'draft'
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
      if(this.ValID ==''){
        self.$message({
          showClose: true,
          message: '请选择删除的任务',
          type: 'error'
        });
      }else{
        self.$confirm('此操作将永久删除任务:'+self.Valtitle+' , 是否继续?', '提示', {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          type: 'warning'
        }).then(() => {
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
          self.$message({
            type: 'success',
            message: '删除成功!'
          });
        }).catch(() => {
          this.$message({
            type: 'info',
            message: '已取消删除'
          });          
        });
      }
      this.dialogTableVisible = false // loading层关闭
      // this.$notify({
      //   title: '成功',
      //   message: '删除成功',
      //   type: 'success',
      //   duration: 2000
      // })
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
        var qs = require('qs') // 处理post内容格式
        axios.post('http://127.0.0.1:3000/upstatus', qs.stringify({
          status: status,
          id: row.ID,
          exauthor:row.author
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
        message: '更新成功',
        type: 'success',
        duration: 2000
      })
      row.status = status
    },
    Pushlist() {
      var self = this
      for(var i=0; i<arguments.length; i++){
        var b = arguments[i]
      let a = b.length   
      for(var j=0; j<a; j++){
          self.alllist.push(b[j])
      }  
      }  
      if(self.alllist.length ==0){
        self.alllist.push({msg:'null'})
      } 
    },
    opendialog(index,ID) {
      console.log(this.listQuery.page)
      this.listQuery2=[]
      this.liswork=[]
      this.checkwork=[]
      this.Askwork=[]
      
      this.queindex = ID
      var self = this
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
          }).catch(function(error) {
            console.log(error)
          })
          if(this.list[index].status != "draft"){
            self.dialogMyqVisible2 = true
          } else {
            this.dialogMyqVisible = true
          }
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

  }
}
</script>
