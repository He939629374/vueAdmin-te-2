
<template>
<div>
  <div class="nav_bar_top" >
  <image class="nav_logo"
         src="bmlocal://assets/搜索.png"
         ></image>
  <text :style="BLZ" @click="BLZclick" >办理中</text>
  <text :style="BLSX" @click="BLSXclick" >所有事项</text>
  <image class="nav_logo"
         src="bmlocal://assets/搜索.png"
         ></image>
</div>
<div v-if="BLZisActive">
<div class="nav_bar_next">
<div class="nav_bar_btn" :style="{backgroundColor:btncolor[5],}" @click="onc(5)"><text :style="{color:color[5]}" class="t" >全部</text></div>
<div class="nav_bar_btn" :style="{backgroundColor:btncolor[0],}" @click="onc(0)"><text :style="{color:color[0]}" class="t" >临时保存</text></div>
<div class="nav_bar_btn" :style="{backgroundColor:btncolor[1],}" @click="onc(1)"><text :style="{color:color[1]}" class="t" >已受理,正预审</text></div>
<div class="nav_bar_btn" :style="{backgroundColor:btncolor[2],}" @click="onc(2)"><text :style="{color:color[2]}" class="t" >预审不通过</text></div>
<div class="nav_bar_btn" :style="{backgroundColor:btncolor[3],}" @click="onc(3)"><text :style="{color:color[3]}" class="t" >预审结束,可交件</text></div>
<div class="nav_bar_btn" :style="{backgroundColor:btncolor[4],}" @click="onc(4)"><text :style="{color:color[4]}" class="t" >已退回</text></div>
</div>
<list class="list" @loadmore="fetch" loadmoreoffset="10" >
<cell class="cell" v-for="item in items" >
<div class="box_vfor">
  <div class="box_left" :style="{borderColor:item.style}"><text class="t1">{{item.status}}</text></div>
    <div class="box_right" >
      <div class="title">
        <text class="title_dw">{{item.dw}}</text>
        <text class="title_Num">{{item.Num}}</text>
      </div>
      <div class="body">
        <div class="body_left">
          <text class="body_left_Name">{{item.CASENAME}}</text>
          <text class="body_left_Name">{{item.CASENUM}}</text>
        </div>
        <div class="body_right">
          <text class="body_right_Name">{{item.CASEADD}}</text>
        </div>
      </div>
    </div>
</div>
</cell>
</list>
</div>
<div v-else>
  <wlist></wlist>
</div>
</div>

</template>

<style scoped>
.BLSX_dw{
  text-align: center;
  font-size: 34px; 
  color: #fff;
  font-weight:600;
}
.BLSX_vfor{
  /* box-shadow:inset 0px 1px 10px 5px #ccc; */
  margin-top: 20px;
  width: 750px;
  height: 2000px;
  flex-direction:column;
  align-items:center;
}
.BLSX_Num{
  font-size: 28px; 
  color: black;
  font-weight:500;
}
.BLSX_title{
  padding-left: 10px;
  height: 60px;
  width: 600px;
  background-color: #48d262;
  flex-direction:row;
  align-items:center;
}
.body_left_Name{

  font-size: 26px;
  margin-bottom: 20px;
}
.body_right_Name{
  font-size: 26px;
}
.body{
  flex-direction:row;
  height: 200px;
  width: 600px;
  background-color: #f2f3f4e7;
}
.body_left{
  box-shadow:inset 0px 1px 10px 5px #ccc;
  width: 450px;
  justify-content:center;
}
.body_right{

  width: 150px;
  justify-content:space-around;
  align-items:center;
}
.title_dw{
  text-align: center;
  font-size: 34px; 
  color: #fff;
  font-weight:600;
}
.title_Num{
  font-size: 28px; 
  color: #fff;
}
.title{
  padding-left: 10px;
  height: 60px;
  background-color: #48d262;
  flex-direction:row;
  align-items:center;
}
.t1{
  width: 32px;
  font-size: 24px; 
}
.box_vfor{
  margin-top: 20px;
  width: 750px;
  height: 250px;
  flex-direction:row;
  justify-content:space-around;
  align-items:center;
}
.box_left{
  justify-content:center;
  align-items:center;
  width: 100px;
  background-color: #fff;
  height: 250px;
  
  border-width: 4px;
}
.box_right{
  box-shadow:inset -5px -5px -5px 4px #ccc;

  width: 600px;
  background-color: #f2f3f4e7;
  height: 250px;

}
	.nav_bar_btn {
    margin-top: 15px;
    margin-left: 5px;
    margin-right: 5px;
		background-color: #fff;
		font-family: "黑体";
    justify-content:center;
    align-items:center;
    border-radius:7px;
	}

.nav_bar_next{
      justify-content:space-between;
      flex-direction: row;
}
.t{
      justify-content:space-between;
      flex-direction: row;
      font-family: "微软雅黑";
      font-size: 21;
      margin: 10px;
      color: #48d262;
}
    .nav_logo {
      margin-top: 50%;
      margin-left:20%;
        width: 60%;
        height: 60%;
    }
      .nav_bar_top1 {
      flex-direction: row;    
      height: 100px;
      width: 750px;
      background-color: #fff;
      border-width:0;
  }
  .nav_bar_top {
      justify-content:space-between;
      flex-direction: row;    
      height: 120px;
      width: 750px;
      background-color: #48d262;
      border-width:0;
  }
  .item-container {
    width: 750px;
    background-color: #f2f3f4;
    align-items: center;
    justify-content: center;
  }
</style>
<script>
import wlist from './weexui.vue';
import { WxcMinibar } from 'weex-ui';
  import { WxcTabBar, Utils } from 'weex-ui';

  // https://github.com/alibaba/weex-ui/blob/master/example/tab-bar/config.js 
  import Config from './config'

  export default {
    components: { WxcTabBar,WxcMinibar,wlist },
    data: () => ({
      items:[{
        status:'已退回',
        dw:'欧力集团',
        Num:'[三规卷[2014]0411号]',
        CASENAME:'(预审)城市建(构)筑物工程规划条件核实',
        ACSENUM:'预440607201802436号',
        CASEADD:'厂房1',
        style:'#ec4949'
      },
      {
        status:'临时保存',
        dw:'欧力集团',
        Num:'[三规卷[2014]0411号]',
        CASENAME:'(预审)城市建(构)筑物工程规划条件核实',
        ACSENUM:'预440607201802436号',
        CASEADD:'厂房1',
        style:'#ec4949'
      },{
        status:'已受理,正预审',
        dw:'欧力集团',
        Num:'[三规卷[2014]0411号]',
        CASENAME:'(预审)城市建(构)筑物工程规划条件核实',
        ACSENUM:'预440607201802436号',
        CASEADD:'厂房1',
        style:'#ec4949'
      },
      {
        status:'预审不通过',
        dw:'欧力集团',
        Num:'[三规卷[2014]0411号]',
        CASENAME:'(预审)城市建(构)筑物工程规划条件核实',
        ACSENUM:'预440607201802436号',
        CASEADD:'厂房1',
        style:'#ec4949'
      },
      {
        status:'预审结束,可交件',
        dw:'欧力集团',
        Num:'[三规卷[2014]0411号]',
        CASENAME:'(预审)城市建(构)筑物工程规划条件核实',
        ACSENUM:'预440607201802436号',
        CASEADD:'厂房1',
        style:'#ec4949'
      }],
      itemsALL:[],
      BLZ:{
        borderColor:'#fff',
        borderBottomWidth: '0px',
        fontSize: '40px',
        marginTop:'56px',
      },
      BLSX:{
        borderColor:'#fff',
        borderBottomWidth: '0px',
        fontSize: '40px',
        marginTop:'56px',
      },
      BLZisActive:false,
      BarHeight:'',
      tabTitles: Config.tabTitles,
      tabStyles: Config.tabStyles,
      itemYSL:[],
      itemYSBTG:[],
      itemYSJS:[],
      itemLSBC:[],
      itemYTH:[],
      itemsSY:[],
      btncolor:['#fff','#fff','#fff','#fff','#fff','#fff'],
      color:['#48d262','#48d262','#48d262','#48d262','#48d262','#48d262'],
    }),
    created () {
      this.$notice.toast({
					message: this.items.length
        })
        
      for(var i=0;i<this.items.length ;i++){
        this.itemsSY.push(this.items[i])
        if(this.items[i].status==='已受理,正预审'){
           this.items[i].style = '#bcb100'
           this.itemYSL.push(this.items[i])
           this.itemsALL.push(this.items[i])
        }else if(this.items[i].status==='预审不通过'){
          this.items[i].style = '#ec4949'
          this.itemYSBTG.push(this.items[i])
          this.itemsALL.push(this.items[i])
        }else if(this.items[i].status==='预审结束,可交件'){
          this.items[i].style = '#48d262'
          this.itemYSJS.push(this.items[i])
          this.itemsALL.push(this.items[i])
        }else if(this.items[i].status==='临时保存'){
          this.items[i].style = '#1b7fa9'
          this.itemLSBC.push(this.items[i])
          this.itemsALL.push(this.items[i])
        }else if(this.items[i].status==='已退回'){
          this.items[i].style = '#d77900'
          this.itemYTH.push(this.items[i])
          this.itemsALL.push(this.items[i])
        }
      }
      // this.$notice.toast({
			// 		message: weex.config.env.statusBarHeight 
			// 	})
      this.BarHeight = weex.config.env.statusBarHeight
      const tabPageHeight = Utils.env.getPageHeight();
      // 如果页面没有导航栏，可以用下面这个计算高度的方法
      // const tabPageHeight = env.deviceHeight / env.deviceWidth * 750;
      const { tabStyles } = this;
      this.contentStyle = { height: (tabPageHeight - tabStyles.height) + 'px' };
    },
    methods: {
      onc(index){
        var self = this
        for(var i=0;i<6;i++){
          if(i===index){
            this.btncolor[i] = '#48d262'
            this.color[i] = '#fff'
          }else{
            this.btncolor[i] = '#fff'
            this.color[i] = '#48d262'
        }                
        }
        if(index===0){
          this.items = this.itemLSBC
        }
        if(index===1){
          this.items = this.itemYSL
        }
        if(index===2){
          this.items = this.itemYSBTG
        }
        if(index===3){
          this.items = this.itemYSJS
        }
        if(index===4){
          this.items = this.itemYTH
        }   
        if(index===5){
          this.items = this.itemsALL
        }
      },
      BLZclick(){
        this.BLZisActive = true
        this.BLZ.borderBottomWidth='6px'
        this.BLSX.borderBottomWidth='0px'
      },
      BLSXclick(){
        this.BLZisActive = false
        this.BLSX.borderBottomWidth='6px'
        this.BLZ.borderBottomWidth='0px'
      },
      wxcTabBarCurrentTabSelected (e) {
        const index = e.page;
        // console.log(index);
      }
    }
  };
</script>