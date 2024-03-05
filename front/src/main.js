import Vue from 'vue'
import App from './App'
import router from './router'
import Buefy from 'buefy'
import 'buefy/dist/buefy.css'
import VueAxios from 'vue-axios'
import { securedAxiosInstance, plainAxiosInstance } from './backend/axios/index'

Vue.use(Buefy, {
  defaultIconPack: 'fas'
})
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
