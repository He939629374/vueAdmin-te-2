
<template>

</template>

<style scoped>
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
import { WxcMinibar } from 'weex-ui';
  import { WxcTabBar, Utils } from 'weex-ui';

  // https://github.com/alibaba/weex-ui/blob/master/example/tab-bar/config.js 
  import Config from './config'

  export default {
    components: { WxcTabBar,WxcMinibar },
    data: () => ({
      BarHeight:'',
      tabTitles: Config.tabTitles,
      tabStyles: Config.tabStyles
    }),
    created () {
      this.$notice.toast({
					message: weex.config.env.statusBarHeight 
				})
      this.BarHeight = weex.config.env.statusBarHeight
      const tabPageHeight = Utils.env.getPageHeight();
      // 如果页面没有导航栏，可以用下面这个计算高度的方法
      // const tabPageHeight = env.deviceHeight / env.deviceWidth * 750;
      const { tabStyles } = this;
      this.contentStyle = { height: (tabPageHeight - tabStyles.height) + 'px' };
    },
    methods: {
      wxcTabBarCurrentTabSelected (e) {
        const index = e.page;
        // console.log(index);
      }
    }
  };
</script>