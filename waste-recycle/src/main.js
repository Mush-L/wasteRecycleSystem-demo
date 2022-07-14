import Vue from 'vue'
import App from './App.vue'
import router from './router'
import store from './store'
import request from './utils/request';

// 引入并使用 Element UI
import Element from 'element-ui'
import 'element-ui/lib/theme-chalk/index.css';
Vue.use(Element)

// 使用全局 请求
Vue.prototype.request = request

Vue.config.productionTip = false

new Vue({
  router,
  store,
  render: h => h(App)
}).$mount('#app')
