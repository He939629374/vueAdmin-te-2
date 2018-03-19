<template>
    <div class="app-container " style="width:60%">
      <el-form ref="form1" :model="form" label-width="80px" >
        <!-- <el-form-item label="头像上传" >
          <el-upload
          class="avatar-uploader"
          action="D:\迅雷下载"
          :show-file-list="false"
          :on-success="handleAvatarSuccess"
          :before-upload="beforeAvatarUpload">
            <img  v-if="imageUrl" :src="imageUrl" class="avatar">
            <i v-else class="el-icon-plus avatar-uploader-icon"></i>
          </el-upload>
        </el-form-item> -->
         <img  v-if="imageUrl" :src="form.imageUrl"  class="avatar-uploader" style="width:200px;height:200px" >
         <input type="file" @change="changeImage($event)" ref="avatarInput" >
      </el-form>        
      <el-form ref="form2" label-width="80px" :inline="true" :model="form" class="demo-form-inline">
        <el-form-item label="账号" prop="account">
          <el-input v-model="form.account"></el-input>
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
      <el-form ref="form" :model="form" label-width="80px" >
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
        <el-form-item label="个人签名" prop="desc">
          <el-input type="textarea" v-model="form.desc"></el-input>
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
.avatar-uploader .el-upload,img {
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
    width: 100px;
    height: 100x;
    line-height: 100px;
    text-align: center;
  }
  .avatar {
    width: 178px;
    height: 178px;
    display: block;
  }
</style>

<script>
  export default {
    data() {
      return {
        dialogStatus: false,
        form: {
          account: '',
          name: '',
          // region: '',
          date1: '',
          // date2: '',
          // delivery: false,
          type: [],
          resource: '',
          desc: '',
          phone: '',
          mailbox: '',
          imageUrl: '',
          asd: '1',
          imageUrl1: 'false'
        }
      }
    },
    created() {
      // this.imageUrl = require('../../assets/QQ8.jpg')
      this.imageUrl = 'data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7'
    },
    methods: {
      changeImage(file) {
        var self = this
        var reader = new FileReader()
        reader.readAsDataURL(this.$refs.avatarInput.files[0])
        reader.onload = function(evt) {
          self.form.imageUrl = reader.result
          console.log(self.form.imageUrl)
        }
      },
      handleAvatarSuccess(res, file) {
        // this.imageUrl = URL.createObjectURL(file.raw)
        var reader = new FileReader()
        reader.readAsDataURL = (file.files[0])
        reader.onload = function() {
          this.imageUrl = reader.readAsDataURL
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
      },
      resetForm(formName) {
        this.$refs[formName].resetFields()
        this.$refs['form1'].resetFields()
        this.$refs['form2'].resetFields()
      }
    }
  }
</script>