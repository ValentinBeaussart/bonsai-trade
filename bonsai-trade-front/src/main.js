import Vue from 'vue'
import App from './App'
import router from './router'
import { securedAxiosInstance, plainAxiosInstance } from './backend/axios/index'
import { BootstrapVue, IconsPlugin } from 'bootstrap-vue'
import 'bootstrap/dist/css/bootstrap.css'
import 'bootstrap-vue/dist/bootstrap-vue.css'

Vue.use(BootstrapVue)
Vue.use(IconsPlugin)
Vue.prototype.$http = {
  secured: securedAxiosInstance,
  plain: plainAxiosInstance
}
Vue.config.productionTip = false
// eslint-disable-next-line no-new
new Vue({
  el: '#app',
  router,
  securedAxiosInstance,
  plainAxiosInstance,
  components: { App },
  template: '<App/>'
})
