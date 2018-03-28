<template>
  <div class="app-container ">
    <div class="filter-container" style="padding-bottom:10px">
        <h2>此处标题</h2>
    <div class="filter-container1" style="padding-bottom:10px">
    <el-cascader
        expand-trigger="hover"
        :options="options"
        v-model="selectedOptions2">
    </el-cascader>
      <el-button class="filter-item" type="primary"  icon="el-icon-search" @click="handleCreate">新增</el-button>
      <myQ ref="Q1" :list="listQuery2" :lis="liswork" :checkQuery="checkwork" :AskQuery="Askwork">

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
            edit: true,
            value4: ''
          },
          {
            title: 'asdd2',
            edit: true,
            value4: ''
          }
        ],
        checkwork: [
          {
            id: 2,
            checked: false,
            title: 'asddas',
            check: ['上海', '北京', '广州', '深圳'],
            edit: true
          },
          {
            id: 1,
            checked: false,
            title: 'adss',
            check: ['上海1', '北京1', '广州1', '深圳1'],
            edit: true
          }
        ],
        Askwork: [
          {
            title: 'asd112',
            input10: '',
            edit: true
          },
          {
            title: 'eqd12',
            input10: '',
            edit: true
          }
        ]
      }
    },
    components: { myQ },
    methods: {
      handleCreate() {
        console.log(this.selectedOptions2)
        if (this.selectedOptions2.length > 1) {
          if (this.selectedOptions2[1] === '是否') {
            this.listQuery2.push({ title: 'moren', radio: '', edit: true })
          } else {
            this.liswork.push({ title: 'moren', value4: '', edit: true })
          }
        } else if (this.selectedOptions2 === '多选') {
          this.checkwork.push({ title: 'moren', checked: 'false', edit: true, check: ['上海', '北京', '广州', '深圳'] })
        } else if (this.selectedOptions2 === '填空') {
          this.Askwork.push({ title: 'moren', input10: '', edit: true })
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
