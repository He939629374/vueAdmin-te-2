<template>
    <div class="app-container " style="width:60%">
      <el-form ref="form1" v-model="form" label-width="80px" style="margin-left:40px">
        <el-form-item label="头像上传" >
        <el-upload
          class="avatar-uploader"
          action="http://127.0.0.1:3000/upload"
          :data ="localid"
          :show-file-list="false"
          :on-success="handleAvatarSuccess"
          :before-upload="beforeAvatarUpload">
          <img v-if="imageUrl" :src="form.imageUrl" class="avatar" >
          <i v-else class="el-icon-plus avatar-uploader-icon"></i>
        </el-upload>
        </el-form-item>
         <!-- <img  v-if="imageUrl" :src="form.imageUrl"  class="avatar-uploader" style="width:200px;height:200px" >
         <input type="file" @change="changeImage($event)" ref="avatarInput" > -->
      </el-form>        
      <el-form ref="form2" label-width="80px" :inline="true" v-model="form" class="demo-form-inline">
        <el-form-item label="账号" prop="user_name">
          <el-input v-model="form.user_name"></el-input>
        </el-form-item>
        <el-form-item label="姓名" prop="name">
          <el-input v-model="form.name"></el-input>
        </el-form-item>
        <el-form-item label="电话" prop="phone">
          <el-input v-model="form.phone"></el-input>
        </el-form-item>
        <el-form-item label="邮箱" prop="mailbox">
          <el-input v-model="form.mailbox"></el-input>
        </el-form-item>
      </el-form>
      <el-form ref="form" v-model="form" label-width="80px" >
        <el-form-item label="生日" prop="date1">
          <el-col :span="8">
            <el-date-picker type="date" placeholder="选择日期" v-model="form.date1" style="width: 100%;"></el-date-picker>
          </el-col>
        </el-form-item>
        <el-form-item label="性别" prop="resource">
          <el-radio-group v-model="form.resource">
            <el-radio label="男"></el-radio>
            <el-radio label="女"></el-radio>
          </el-radio-group>
        </el-form-item>
        <el-form-item label="个人签名" prop="descc">
          <el-input type="textarea" v-model="form.descc"></el-input>
        </el-form-item>
        <el-form-item>
          <div v-if="dialogStatus=='true'" >
            <el-button type="primary" @click="updata">确定</el-button>
            <el-button  @click="resetForm('form')">重置</el-button>
            <el-button>修改密码</el-button>
          </div>
          <el-button v-else type="primary" @click="dialogStatus='true'">修改</el-button>
        </el-form-item>
      </el-form>
    </div>
</template>
<style>
img{
 width:auto;
 height:auto;
 max-width:100%;
 max-height:100%;
}
.avatar-uploader .el-upload {
    width:50px;height:50px;
    border: 1px dashed #d9d9d9;
    border-radius: 6px;
    cursor: pointer;
    position: relative;
    overflow: hidden;
  }
  .avatar-uploader .el-upload:hover {
    border-color: #409EFF;
  }
  .avatar-uploader-icon {
    font-size: 28px;
    color: #8c939d;
    width: 178px;
    height: 178px;
    line-height: 178px;
    text-align: center;
  }
  .avatar {
    width: 178px;
    height: 178px;
    display: block;
  }
</style>

<script>
import axios from 'axios'
  export default {
    data() {
      return {
        localname:'',
        imageUrl:true,
        dialogStatus: false,
        form: []
      }
    },
    created() {
      var  self =this
      this.localid = {localid:localStorage.userid}
      this.fetchData()

    },
    methods: {
    fetchData() {
      var self = this
      axios.get('http://127.0.0.1:3000/selper' + '?ID=' + localStorage.userid)
        .then(function(response) {
          console.log(response.data)
          self.form = response.data[0]
           // this.imageUrl = require('../../assets/QQ8.jpg')        
          self.form.imageUrl = require('./../../../koa2-test/'+response.data[0].imageUrl)//vueAdmin-te-2/koa2-test/public/uploads/微信图片_20180426102414.jpg'
          //console.log(self.form.imageUrl)
        }).catch(function(error) {
          console.log(error)
        })
    },
      handleAvatarSuccess(res, file) {
        var self = this
         this.imageUrl = URL.createObjectURL(file.raw)
         var reader = new FileReader()
          reader.readAsDataURL(file.raw)
          reader.onload = function(evt) {
          self.form.imageUrl = reader.result
          localStorage.imageUrl = ('public/uploads/'+file.name)
          self.$root.$emit('imageUrl', localStorage.imageUrl);
         console.log(localStorage)
        }
      },
      beforeAvatarUpload(file) {
        const isJPG = file.type === 'image/jpeg'
        const isLt2M = file.size / 1024 / 1024 < 2
        if (!isJPG) {
          this.$message.error('上传头像图片只能是 JPG 格式!')
        }
        if (!isLt2M) {
          this.$message.error('上传头像图片大小不能超过 2MB!')
        }
        return isJPG && isLt2M
      },
      updata() {
        this.dialogStatus = false
        var self = this
        var qs = require('qs') // 处理post内容格式
        var da_te =self.moment(self.form.date1).format('YYYY-MM-DD')
        axios.post('http://127.0.0.1:3000/upmsg' ,qs.stringify({
            user_name:self.form.user_name,
            name: self.form.name,
            phone: self.form.phone,
            mailbox: self.form.mailbox,
            date1: da_te,
            resource: self.form.resource,
            descc: self.form.descc,
            id:localStorage.userid
          })).then(function(response) {     
            localStorage.username =  self.form.user_name
            self.$notify({
              title: '成功',
              message: '修改成功',
              type: 'success'
            });
          }).catch(function(error) {
            self.$notify({
              title: '错误',
              message: error,
            });
          })
      },
      resetForm(formName) {
        this.$refs[formName].resetFields()
        this.$refs['form1'].resetFields()
        this.$refs['form2'].resetFields()
      }
    }
  }
</script>
