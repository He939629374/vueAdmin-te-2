<template>
  <div>
    <div>
      <div v-for="(item,index) in list" :key='index' > 
        <textarea v-model="item.title"  class="active"></textarea>
        <el-button @click="del(list,index)" v-if="isdel">删除</el-button>
        <el-radio v-model="item.radio" label="1" :disabled="isinput">是</el-radio>
        <el-radio v-model="item.radio" label="0" :disabled="isinput">否</el-radio>
      </div>
    </div>
      <div>
      <div v-for="(item,index) in lis" :key='index'>
        <textarea v-model="item.title"  class="active"></textarea>
        <el-button @click="del(lis,index)" v-if="isdel">删除</el-button>
        <el-rate
        :disabled="isinput"
        v-model="item.radio"
        :colors="['#99A9BF', '#F7BA2A', '#FF9900']"
        show-text>
        </el-rate>
      </div>
      </div>

      <div>
      <div v-for="(item,index) in checkQuery" :key='index'>
        <textarea v-model="item.title"  class="active"></textarea>
        <el-button @click="del(checkQuery,index)" v-if="isdel">删除</el-button>
        <div>
          <el-checkbox-group v-model="checkQuery[index].radio">
                <el-checkbox v-for="mpb in checkQuery[index].ceck" :key="mpb" :label='mpb' :disabled="isinput">{{mpb}}</el-checkbox>
          </el-checkbox-group>
        </div>
      </div>
      </div>

      <div>
      <div v-for="(item,index) in AskQuery" :key='index'>
        <textarea v-model="item.title"  class="active"></textarea>
        <el-button @click="del(AskQuery,index)" v-if="isdel">删除</el-button>
        <el-input
          type="textarea"
          autosize
          placeholder="请输入内容"
          v-model="item.radio"
          clearable
          :disabled="isinput" >
        </el-input>
      </div>
      </div>
  </div>
</template>

<script>
  export default {
    data() {
      return {
      }
    },
    props: ['list', 'lis', 'checkQuery', 'AskQuery','isdel','isinput'],
    methods: {

      handleCreate() {
      },
      confirmedit(index) {
        this.item[index].edit = false
      },
      del(a, index) {
        console.log(a)
        a.splice(index, 1)
      }
    }
  }
</script>
<style>
/* .el-button{
  padding: 7px 5px;
} */
.active{
  margin-top: 10px;
  display: block;
  border-width: 0px;
  border-style: inset;
  border-image: initial;
}
.el-input--small .el-input__inner {
    height: 30px;
}
.filter-container1{
  width: 500px;
  margin: auto;
}
#CreatUl{
    width: 800px;
    background: #0095da;
    padding: 6px auto;

}
#CreatUl li{
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
