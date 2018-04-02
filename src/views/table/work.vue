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
      <el-button v-else class="filter-item" type="success"  icon="el-icon-circle-ceck-outline" @click="handleSave">保存</el-button>
      <myQ ref="Q1" :list="listQuery2" :lis="liswork" :checkQuery="checkwork" :AskQuery="Askwork" :isdel='iswork'>

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
        iswork:'',
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
    props:['qindex','status'],
    components: { myQ },
    created(){
    },
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
        console.log(this.qindex)
        console.log(this.alllist)
        var qs = require('qs') // 处理post内容格式
        // axios.post('http://127.0.0.1:3000/addques', qs.stringify({
        //   alllist:self.alllist,
        //   qindex:self.qindex
        // }))
        // .then(function(response) {
        //   self.alllist=[]
        //   self.listLoading = false
        //   self.$router.go(0);
        // }).catch(function(error) {
        //   console.log(error)
        // })
        this.dialogMyqVisible = true
this.$router.push({
path:this.$route.fullPath, // 获取当前连接，重新跳转
query:{
_time:new Date().getTime()/1000  // 时间戳，刷新当前router
  }
})
      },
      handleCreate() {
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
      }
    }
}
</script>
<style>

</style>
