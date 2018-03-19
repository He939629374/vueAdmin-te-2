<template>
  <div class="app-container ">
    <div class="filter-container" style="padding-bottom:10px">
        <h2>此处标题</h2>
    <div class="filter-container" style="padding-bottom:10px">
      <el-select clearable style="width: 110px" class="filter-item" v-model="headOptions.type" placeholder="类型">
        <el-option v-for="item in typeOptions" :key="item" :label="item" :value="item" >
        </el-option>
      </el-select>
      <el-select clearable style="width: 110px" class="filter-item" v-model="headOptions.status" placeholder="值">
        <el-option v-for="item in statusOptions" :key="item" :label="item" :value="item" >
        </el-option>
      </el-select>
      <el-button class="filter-item" type="primary"  icon="el-icon-search" @click="handleCreate">新增</el-button>
      <div v-for="(item,index) in listQuery" :key='index'>
        <p >{{ item.title }}</p>
        <el-radio v-model="item.radio" label="1">是</el-radio>
        <el-radio v-model="item.radio" label="0">否</el-radio>
      </div>
      <div v-for="(item,index) in listQuery" :key='index'>
        <p >{{ item.title }}</p>
        <el-rate
        v-model="value4"
        :colors="['#99A9BF', '#F7BA2A', '#FF9900']"
        show-text>
        </el-rate>
      </div>
      <div v-for="(item,index) in checkQuery" :key='index'>
        <p >{{ item.title }}</p>
      </div>
      <div>
        <el-checkbox-group v-for="(item,index) in checkQuery" :key='index'>
        <el-checkbox :label="item.checkList[index]"></el-checkbox>
        </el-checkbox-group>
      </div>
    </div>
    </div>
  </div>
</template>

<script>
  export default {
    data() {
      return {
        typeOptions: ['单选', '多选', '填空', '上传'],
        statusOptions: ['是否', '星级'],
        headOptions: {
          type: '',
          status: ''
        },
        listQuery: [
          {
            title: 'asd',
            radio: '1'
          }
        ],
        value4: '',
        checkQuery: [
        {
          title:'asddas',
          checkList: ['a','b','c']
        }],
        
      }
    },
    methods: {
      handleCreate() {
      }
    }
  }
</script>
<style>
#CreatUl{
    width: 800px;
    background: #0095da;
    padding: 6px auto;

}
#CreatUl li{
    width: 160px;
    display: inline;
    border-right: 1px solid #0072bc;
}
#CreatUl li a{
    font-size: 16px;
    line-height: 36px;
    margin: 10px 10px;
}
a:hover{
    color: #f58220;
    background: #FFF;
    border-radius: 4px;
    margin: 0px;
}

</style>
