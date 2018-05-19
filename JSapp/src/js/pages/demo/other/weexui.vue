
<template>
<div>
 
<list class="list" @loadmore="fetch" loadmoreoffset="10" >
<cell class="cell" v-for="item in itemsSY">
<div class="BLSX_vfor">
  <div class="BLSX_title">
     <text class="BLSX_dw">{{item.dw}}</text>  
  </div>
  <div class="BLSX_title" style="background-color: #fff;justify-content:space-between">
     <text class="BLSX_Num">{{item.Num}}</text>
     <img src="bmlocal://assets/小三角.png" alt="小三角" style="width:35px;height:40px;margin-right:30px">
  </div>
</div>
</cell>
</list>
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
  height: 150px;
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

</style>
<script>
import { WxcMinibar } from 'weex-ui';
  import { WxcTabBar, Utils } from 'weex-ui';

  // https://github.com/alibaba/weex-ui/blob/master/example/tab-bar/config.js 
  import Config from './config'

  export default {
    components: { WxcTabBar,WxcMinibar },
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
    },
    methods: {
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