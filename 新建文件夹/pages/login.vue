<template>
	<div>
		<image class="bg" src="bmlocal://assets/水汇三江.png"></image>
		<div class="box">
		<div>
            <image class="title_h" src="bmlocal://assets/三水区规划咨询服务平台.png"></image>
            <!-- <text class="title_h" style="text-shadows:0" >三水区规划咨询服务平台</text> -->
        </div>
			<div class="box-input">
				<div class="box-content">
					<input v-model="username" class="ipt" id="username"  placeholder="用户名" placeholder-color="#fff" ></input>
				</div>
				<div class="box-content">
					<input v-model="password" type="password" id="password" class="ipt" placeholder="密码" placeholder-color="#fff"></input>
				</div>
			</div>

			<div @click="submit" type="success" size="large" value="登录" style="margin-top:40px" class="login-btn">
                <text class="txt-login">登录</text>
            </div>

    <!-- <div style="margin-top: 80px;width:400px; height:60px;background-color: #FFE4C4; box-shadow: 5px  5px 5px rgba(99, 87, 87, 0.8);">
      <text class="title" style="text-align: center">Hello {{target}}</text>
    </div> -->
    

		</div>
	</div>
</template>
<style scoped>
input::-webkit-input-placeholder{
    color: rgb(99, 87, 87)
}
.title_h{
    width: 560px;
    height: 60px;
}
/* .title_h{
    font-size:48px;
    font-weight:bold;
    color:#fff;
    margin-bottom: 100px;
    text-shadow: 5px 5px 5px rgb(37, 6, 6);
} */
    .txt-login{
        font-size:36px;
        color:#fff;
    }
	.txtlogpassword {
		font-family: "微软雅黑";
		font-size: 28;
		color: #fff;
	}

	.selectbox-unselected {
		width: 30;
		height: 30;
		border-width: 1;
		border-radius: 15;
		border-color: #fff;
		margin-right: 20;
		margin-top: 5;
		background-color: none;
	}

	.selectbox-selected {
		width: 30;
		height: 30;
		border-width: 1;
		border-radius: 15;
		border-color: #fff;

		background-color: #fff;
	}

	.remember-box {
		height: 30;
		padding-top: 20;

		margin-right: 20;

		flex-direction: row;
	}

	.bg {
		flex: 1;
        justify-content:center;
        align-items:center;
        overflow: hidden;

	}

	.logo {
		width: 340;
		height: 340;
		position: absolute;
		top: 200;
		left: 255;
		align-items: center;
	}

	.login-icon {
		height: 60;
		width: 60;
		margin-left: 10;
		margin-right: 20;
	}

	.box {
		position: absolute;
		top: 250;
		left: 56;
		align-items: center;
	}

	.box-input {
		padding-top: 100;
		padding-left: 20;
		padding-right: 20;
	}

	.ipt {
		width: 360;
		height: 40;
		font-size: 28;
		/* background-color: transparent; */
		color: #fff;
		font-family: "黑体";
	}

	.txtcontent {
		font-family: "黑体";
		font-size: 28;
		color: #fff;
		width: 150;
	}

	.box-content {
		flex-direction: row;
		font-size: 12px;
		margin-bottom: 40px;
		align-items: center;
		border-bottom-width: 2px;
		border-bottom-color: #fff;
		height: 80;
		width: 600;
		padding-bottom: 25;
	}

	.login-btn {
		flex: 1;
		background-color: #48d262;
		font-family: "黑体";
		height: 80px;
		width: 600px;
        justify-content:center;
        align-items:center;
        border-radius:15px;
	}

    
</style>
<script>
import 'Config'
export default {
	data: function() {
		return {
			//bgpic: require('/../assets/demo.jpg'),
			username: '',
			password: '',
			baseURL: '',
			bgpic: "https://service.fsmap.com.cn/gtghapp/images/login/login_bg.png",
			logopic: "https://service.fsmap.com.cn/gtghapp/images/login/login_logo.png",
			userlogo: 'https://service.fsmap.com.cn/gtghapp/images/login/login_zh.png',
			passwordlogo: 'https://service.fsmap.com.cn/gtghapp/images/login/login_password.png',
		}
	},	
    created:function(){
			var self=this;
			
			this.$storage.get("loginname").then(resData=>{
				if(resData!="undefined" 
				&& typeof(resData)!="undefined" 
				&& resData!=""){
					self.username = resData;
					if(weex.config.env.platform=='iOS'){
						// self.autoSubmitByZW();
					}
				}
			});
	},
	methods:{
		autoSubmitByZW:function(){
			var self=this;
		
			var auth = weex.requireModule('bmAuth');
			auth.touchId({
				title:'登录认证'    // 指纹认证弹窗标题
			}, function(resData){
				if(resData.resCode==0){
					self.$router.open({
					name:'home.index',
					type:'PUSH'
					});  
				}
			})
		},
		submit:function(){
			// this.$notice.loading.show("登陆中")
			var self=this;

			self.$fetch({
				method: 'GET',  
				name:  'Login',
				// url: 'http://172.16.5.216/WEEX_SERVICE/Main/Login', //当前是在apis中配置的别名，你也可以直接绝对路径请求 如：url:http://xx.xx.com/xxx/xxx
				data: {
					username: '1',
					password:'2'
				}
			}).then(resData => {
				// 成功回调
				if(resData.code ==1){
					self.$router.open({
							name: 'demo.other.weex-ui'
							//name:'demo.bmcalendar'
					})
				}else{
					self.$notice.toast({
					message: resData.msg
				})
				}
			}, error => {
				// 错误回调
				this.$notice.toast({
					message: resData.msg
				})
			})
		}
	}

}
</script>