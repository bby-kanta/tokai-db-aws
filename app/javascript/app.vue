<template>
  <div>
    <router-view></router-view>
  </div>
</template>

<script>
import Vue from 'vue'
import VueRouter from 'vue-router'
import InfiniteLoading from 'vue-infinite-loading'
import Ads from 'vue-google-adsense'

import VideosIndex from 'components/videos/VideosIndex.vue'
import VideosShow from 'components/videos/VideosShow.vue'
import VideosEdit from 'components/videos/VideosEdit.vue'
import UsersShow from 'components/users/UsersShow.vue'
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
  mode: 'hash',
  routes: [
    { path: '/',
      name: 'VideosIndex',
      component: VideosIndex },
    { path: '/videos',
      name: 'VideosIndex',
      component: VideosIndex },
    { path: '/videos/:id(\\d+)',  // :id は数値のみに制限する
      name: 'VideosShow',
      component: VideosShow },
    { path: '/videos/edit/:id(\\d+)', 
      name: 'VideosEdit',
      component: VideosEdit },
    { path: '/users/:id(\\d+)',  // :id は数値のみに制限する
      name: 'UsersShow',
      component: UsersShow },
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

Vue.use(VueRouter);
Vue.use(InfiniteLoading, {  //無限スクロール
  props: {
    spinner: 'bubbles',
  },
  slots: { 
      noMore: 'すべて読み込みました',
      noResults: '読み込み完了しています',
  },
});

// google adsense
Vue.use(require('vue-script2'))
Vue.use(Ads.Adsense)
Vue.use(Ads.InArticleAdsense)
Vue.use(Ads.InFeedAdsense)

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
.dip-fl {
  width: 96%;
  display: flex;
  margin: 0 auto;
}

button {
  position: relative;
  display: inline-block;
  padding: 0.25em 0.5em;
  text-decoration: none;
  color: #FFF;
  background: #fd9535;
  border-bottom: solid 2px #d27d00;
  border-radius: 4px;
  box-shadow: inset 0 2px 0 rgba(255,255,255,0.2), 0 2px 2px rgba(0, 0, 0, 0.19);
  font-weight: bold;
}

.orange {
  color: orange;
}
.blue {
  color: blue;
  cursor: pointer;
  display: inline;
}

@media screen and (max-width: 999px){ /*widthが999pxまでのCSS(スマホ用)*/

  .title {
    padding-top: 15px;
  }

}

#overlay{ //モーダルウインドウ
  /*　要素を重ねた時の順番　*/
  z-index:1;
  /*　画面全体を覆う設定　*/
  position:fixed;
  top:0;
  left:0;
  width:100%;
  height:100%;
  background-color:rgba(0,0,0,0.5);
  /*　画面の中央に要素を表示させる設定　*/
  display: flex;
  align-items: center;
  justify-content: center;
  #modal-content { //モーダルウインドウの中身
    z-index:2;
    width:50%;
    padding: 1em;
    background:#fff;
    border-radius: 20px;
    i {
      color: orange;
      cursor: pointer;
    }
    form {
      .comment-form {
        display: flex;
        flex-direction: column;
        input {
          margin : 5px 0;
        }
        textarea {
          width: 100%;
          height: 100px;
          margin : 5px 0;
        }
      }
      .comment-submit {
        display: flex;
        flex-direction: row-reverse;
      }
    }
  }
}

</style>
