<template>
  <div class="app-container ">
    <div class="filter-container" style="padding-bottom:10px">
        <h2>此处标题</h2>
    <div class="filter-container1" style="padding-bottom:10px">
      <el-select clearable style="width: 110px" class="filter-item" v-model="headOptions.type" placeholder="类型">
        <el-option v-for="item in typeOptions" :key="item" :label="item" :value="item" >
        </el-option>
      </el-select>
      <el-select clearable style="width: 110px" class="filter-item" v-model="headOptions.status" placeholder="值">
        <el-option v-for="item in statusOptions" :key="item" :label="item" :value="item" >
        </el-option>
      </el-select>
      <el-button class="filter-item" type="primary"  icon="el-icon-search" @click="handleCreate">新增</el-button>
      <myQ :list="listQuery2" :logo="logoMsg"  :lis="liswork" :checkQuery="checkwork" :AskQuery="Askwork">

      </myQ>
    </div>
    </div>
  </div>
</template>

<script>
  import myQ from '@/components/Options.vue'
  export default {
    data() {
      return {
        logoMsg: { lo: '21' },
        typeOptions: ['单选', '多选', '填空', '上传'],
        statusOptions: ['是否', '星级'],
        headOptions: {
          type: '',
          status: ''
        },
        listQuery2: [
          {
            title: 'asdd',
            radio: '1',
            edit: true
          },
          {
            title: 'asdd2',
            radio: '0',
            edit: true
          }
        ],
        liswork: [
          {
            title: 'asdd',
            radio: '1',
            edit: true,
            value4: ''
          },
          {
            title: 'asdd2',
            radio: '0',
            edit: true,
            value4: ''
          }
        ],
        checkwork: [
          {
            id: 1,
            checked: false,
            title: 'asddas',
            check: ['上海', '北京', '广州', '深圳']
          },
          {
            id: 1,
            checked: false,
            title: 'adss',
            check: ['上海1', '北京1', '广州1', '深圳1']
          }
        ],
        Askwork: [
          {
            title: 'asd112',
            input10: ''
          },
          {
            title: 'eqd12',
            input10: ''
          }
        ]
      }
    },
    components: { myQ },
    methods: {
      handleCreate() {
        if(this.headOptions.type == '单选'){
          this.listQuery2.push({ title: 'moren', radio: '', edit: true })
        }
        else if(this.headOptions.type == '多选'){
          this.checkQuery.push({ title: 'moren', radio: '', edit: true })
        }
        else if(this.headOptions.type == '填空'){
          this.AskQuery.push({ title: 'moren', radio: '', edit: true })
        }
        else if(this.headOptions.type == '上传'){
          
        }
        this.logoMsg.lo = '3'
        // alert(this.listQuery2[1].radio)
      }
    }
}
</script>
<style>

</style>
