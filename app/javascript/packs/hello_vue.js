import Vue from 'vue'
import App from '../app.vue'

import gv from '../mixins/globalValiables'  //グローバルメソッド
Vue.mixin(gv)  

document.addEventListener('DOMContentLoaded', () => {

  const el = document.querySelector('.app')

  if (el == null) {
    return
  }

  new Vue({
    el: el,
    render: h => h(App)
  }).$mount()
})