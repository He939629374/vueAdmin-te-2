<template>
  <div>
    <div>
      <div v-for="(item,index) in list" :key='index' > 
        <el-input v-if="!item.edit" class="item.edit-input" size="small" v-model="item.title"
         @blur="item.edit = !item.edit"
         @focus="focus($event)"
         v-focus
         ></el-input>
        <p v-else @click="item.edit = false" >{{ item.title }}</p>
        <el-radio v-model="item.radio" label="1">是</el-radio>
        <el-radio v-model="item.radio" label="0">否</el-radio>
        <el-button @click="del(list,index)" >删除</el-button>
      </div>
    </div>
      <div>
      <div v-for="(item,index) in lis" :key='index'>
        <el-button @click="del(lis,index)" >删除</el-button>
        <el-input v-if="!item.edit" class="item.edit-input" size="small" v-model="item.title"></el-input>
        <p v-else @click="item.edit = false" >{{ item.title }}</p>
        <el-rate
        v-model="item.value4"
        :colors="['#99A9BF', '#F7BA2A', '#FF9900']"
        show-text>
        </el-rate>
      </div>
      </div>

      <div>
      <div v-for="(item,index) in checkQuery" :key='index'>
        <el-button @click="del(checkQuery,index)" >删除</el-button>
        <el-input v-if="!item.edit" class="item.edit-input" size="small" v-model="item.title"></el-input>
        <p v-else @click="item.edit = false" >{{ item.title }}</p>
        <div>
          <el-checkbox v-for="mpb in checkQuery[index].check" :key="mpb.id" v-model="mpb.checked">{{mpb}}</el-checkbox>
        </div>
      </div>
      </div>

      <div>
      <div v-for="(item,index) in AskQuery" :key='index'>
        <!-- <el-button v-if="item.edit" @click="item.edit = !item.edit" v-model="item.title">修改</el-button>
        <el-button v-else @click="item.edit = !item.edit">完成</el-button> -->
        <el-button @click="del(AskQuery,index)" >删除</el-button>
        <el-input v-if="!item.edit" class="item.edit-input" size="small" v-model="item.title"></el-input>
        <p v-else @click="item.edit = false" >{{ item.title }}</p>
        <el-input
          type="textarea"
          autosize
          placeholder="请输入内容"
          v-model="item.input10"
          clearable>
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
    directives: {
      focus: {
        // 指令的定义
        inserted: function (el) {
          alert("@")
          el.focus()
        }
      }
    },
    props: ['logo', 'list', 'lis', 'checkQuery', 'AskQuery'],
    methods: {
      focus(event) {
        
        // event.currentTarget.select()
      },
      aa(a) {
        alert(a)
      },
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
.el-button{
  padding: 7px 5px;
}
.el-input--small  {
  display: inline-block;
}
.el-checkbox{
  clear: both;
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
    /* width: 160px;
    display: inline; */
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
