import Vue from 'vue'
import VideosSearch from '../components/videos/VideosSearch.vue';

document.addEventListener('DOMContentLoaded', () => {
  const el = document.querySelector('.search-videos-index')

  if (el == null) {
    return
  }

  const { videos } = el.dataset

  const props = {
    videos: videos ? JSON.parse(videos) : [],  //parseメソッドはJSONをJS用に変換して自由に扱えるようにする。
  }

  new Vue({
    el: el,
    render: h => h(VideosSearch, { props })
  }).$mount()
})
