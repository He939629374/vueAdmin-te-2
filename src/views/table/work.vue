<template>
  <div class="app-container " v-loading.body="listLoading">
    <div class="filter-container" style="padding-bottom:10px">
    <el-cascader
        expand-trigger="hover"
        :options="options"
        v-model="selectedOptions2">
    </el-cascader>
      <el-button class="filter-item" type="primary"  icon="el-icon-search" @click="handleCreate">新增</el-button>
      <el-button v-if="status" class="filter-item" type="success"  icon="el-icon-upload" @click="handleSave">提交</el-button>
      <el-button v-else class="filter-item" type="success"  icon="el-icon-circle-check-outline" @click="handleSave">保存</el-button>
      <myQ ref="Q1" :list="listQuery2" :lis="liswork" :checkQuery="checkwork" :AskQuery="Askwork">

      </myQ>
    </div>
    </div>
</template>

<script>
  import axios from 'axios'
  import myQ from '@/components/Options.vue'
  export default {
    data() {
      return {
        alllist:[],
        listLoading: false,
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
        headOptions: {
          type: '',
          status: ''
        },
        listQuery2: [
          {
            id: 0,
            type: '0',
            title: 'asddasdasdasdddddddddddddddddddddddddddddddddddddddddddddddddddddd',
            radio: '1',
            edit: true
          },
          {
            id: 1,
            type: '0',
            title: 'asdd2',
            radio: '0',
            edit: true
          }
        ],
        liswork: [
          {
            id: 0,
            type: '1',
            title: 'asdd',
            edit: true,
            radio: ''
          },
          {
            id: 1,
            type: '1',
            title: 'asdd2',
            edit: true,
            radio: ''
          }
        ],
        checkwork: [
          {
            id: 0,
            type: '2',
            radio: ['北京'],
            title: 'asddas',
            check: ['上海', '北京', '广州', '深圳'],
            edit: true
          },
          {
            id: 1,
            type: '2',
            radio: ['上海1'],
            title: 'adss',
            check: ['上海1', '北京1', '广州1', '深圳1'],
            edit: true
          }
        ],
        Askwork: [
          {
            id: 0,
            type: '3',
            title: 'asd112',
            radio: '',
            edit: true
          },
          {
            id: 1,
            type: '3',
            title: 'eqd12',
            radio: '',
            edit: true
          }
        ]
      }
    },
    props:['qindex','status'],
    components: { myQ },
    methods: {
      Pushlist() {
        var self = this
        for(var i=0; i<arguments.length; i++){
          var b = arguments[i]
        let a = b.length
        for(var j=0; j<a; j++){
            self.alllist.push(b[j])
        }   
        }    
      },
      handleSave() {
        //this.listLoading = true
        var self = this
        this.Pushlist(self.Askwork,self.checkwork,self.liswork,self.listQuery2)
        var qs = require('qs') // 处理post内容格式
        axios.post('http://127.0.0.1:3000/addques', qs.stringify({
          alllist:self.alllist,
          qindex:self.qindex
        }))
        .then(function(response) {
          self.alllist=[]
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
      handleCreate() {
        console.log(this.selectedOptions2)
        if (this.selectedOptions2.length > 1) {
          if (this.selectedOptions2[1] == '是否') {
            this.listQuery2.push({ title: 'moren', radio: '', edit: true,type: '0', id: this.listQuery2.length+1 })
          } else {
            this.liswork.push({ title: 'moren', radio: '', edit: true,type: '1', id:this.liswork.length+1 })
          }
        } else if (this.selectedOptions2 == '多选') {
          this.checkwork.push({ title: 'moren',  radio: ['上海'], edit: true, check: ['上海', '北京', '广州', '深圳'],type: '2', id:this.checkwork+1 })
        } else if (this.selectedOptions2 == '填空') {
          this.Askwork.push({ title: 'moren', radio: '', edit: true,type: '3', id:this.Askwork.length+1 })
        } else {
          this.$message({
            message: '新增类型未指定',
            type: 'warning'
          })
        }
      }
    }
}
</script>
<style>

</style>
