<template>
  <!-- <div id="app">
    <p>{{ message }}</p>
  </div> -->
  <div>
    <router-view></router-view>
  </div>
</template>

<script>
import Vue from 'vue'
import VueRouter from 'vue-router'
import InfiniteLoading from 'vue-infinite-loading'

import VideosIndex from 'components/videos/VideosIndex.vue'
import VideosShow from 'components/videos/VideosShow.vue'
import PeopleIndex from 'components/people/PeopleIndex.vue'
import PeopleShow from 'components/people/PeopleShow.vue'
import PenaltiesIndex from 'components/penalties/PenaltiesIndex.vue'
import PenaltiesShow from 'components/penalties/PenaltiesShow.vue'
import TagsIndex from 'components/tags/TagsIndex.vue'
import TagsShow from 'components/tags/TagsShow.vue'
import MusicsIndex from 'components/musics/MusicsIndex.vue'
import MusicsShow from 'components/musics/MusicsShow.vue'
import PlacesIndex from 'components/places/PlacesIndex.vue'
import PlacesShow from 'components/places/PlacesShow.vue'

const router = new VueRouter({
  routes: [
    { path: '/',
      name: 'VideosIndex',
      component: VideosIndex },
    { path: '/videos/:id(\\d+)',  // :id は数値のみに制限する
      name: 'VideosShow',
      component: VideosShow },
    { path: '/people',
      name: 'PeopleIndex',
      component: PeopleIndex },
    { path: '/people/:id(\\d+)',
      name: 'PeopleShow',
      component: PeopleShow },
    { path: '/penalties',
      name: 'PenaltiesIndex',
      component: PenaltiesIndex },
    { path: '/penalties/:id(\\d+)',
      name: 'PenaltiesShow',
      component: PenaltiesShow },
    { path: '/tags',
      name: 'TagsIndex',
      component: TagsIndex },
    { path: '/tags/:id(\\d+)',
      name: 'TagsShow',
      component: TagsShow },
    { path: '/musics',
      name: 'MusicsIndex',
      component: MusicsIndex },
    { path: '/musics/:id(\\d+)',
      name: 'MusicsShow',
      component: MusicsShow },
    { path: '/places',
      name: 'PlacesIndex',
      component: PlacesIndex },
    { path: '/places/:id(\\d+)',
      name: 'PlacesShow',
      component: PlacesShow },
  ],
  scrollBehavior (to, from, savedPosition) { //リンクをクリックしたら一番上へ
     return { x: 0, y: 0 }
  }

})

Vue.use(VueRouter)
Vue.use(InfiniteLoading, {  //無限スクロール
  slots: {
      noMore: 'すべて読み込みました',
      noResults: '読み込み完了しています',
  },
});

export default {
  router,
}
</script>

// export default {
//   data: function () {
//     return {
//       message: "Hello Vue!"
//     }
//   }
// }

<style lang="scss">
@media screen and (max-width: 999px){ /*widthが999pxまでのCSS(スマホ用)*/

  .title {
    padding-top: 15px;
  }

}

</style>
