import Vue from 'vue';
import VideosIndex from '../components/videos/VideosIndex.vue'


document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    render: h => h(VideosIndex)
  }).$mount()
  document.body.appendChild(app.$el)

  console.log(app)
})