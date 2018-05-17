import Vue from 'vue'

import 'normalize.css/normalize.css'// A modern alternative to CSS resets

import ElementUI from 'element-ui'
import 'element-ui/lib/theme-chalk/index.css'
import locale from 'element-ui/lib/locale/lang/zh-CN'

import '@/styles/index.scss' // global css

import App from './App'
import router from './router'
import store from './store'

import Moment from 'moment'
import '@/icons' // icon
import '@/permission' // permission control

Vue.use(ElementUI, { locale })
Vue.prototype.moment = Moment
Vue.config.productionTip = false

new Vue({
  el: '#app',
  router,
  store,
  template: '<App/>',
  components: { App }
})
// main.js
router.beforeEach((to, from, next) => {
    console.log("asdasdasdad:"+localStorage.userid)
    if(localStorage.username==='admin'){//如果有就直接到首页咯
      next();
    }else{
      if(to.path=='/login'){//如果是登录页面路径，就直接next()
        next();
      }else{//不然就跳转到登录；
        next({path:'/form'});
      }
  //   if (to.path === '/login') {
  //     next({ path: '/form' });
  //    } else {
  //     if (store.getters.roles.length === 0) { // 判断当前用户是否已拉取完user_info信息
  //       store.dispatch('GetInfo').then(res => { // 拉取info
  //         const roles = res.data.role;
  //         store.dispatch('GenerateRoutes', { roles }).then(() => { // 生成可访问的路由表
  //           router.addRoutes(store.getters.addRouters) // 动态添加可访问路由表
  //           next({ ...to, replace: true }) // hack方法 确保addRoutes已完成 ,set the replace: true so the navigation will not leave a history record
  //         })
  //       }).catch(err => {
  //         console.log(err);
  //       });
  //     } else {
  //       next() //当有用户权限的时候，说明所有可访问路由已生成 如访问没权限的全面会自动进入404页面
  //     }
  //   }
  // } else {
  //   if (whiteList.indexOf(to.path) !== -1) { // 在免登录白名单，直接进入
  //     next();
  //   }
  //   else {
  //     next('/login'); // 否则全部重定向到登录页
  //   }
   }
});
