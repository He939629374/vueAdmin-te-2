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
//import '@/permission' // permission control

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
  //首先判断是否有值
  if (sessionStorage.username != 'admin' && to.path ==="/example/tree") {
    next("/form/index");
  }else{
    next();
  }
});