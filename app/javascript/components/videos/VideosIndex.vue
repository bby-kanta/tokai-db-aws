<template>
  <div id="app">
    <SubscriberCounter></SubscriberCounter>
    <div class="tabs">
      <div class="btn-container">
        <button v-for="(tab, index) in tabs"
                :key="tab.id"
                :class="{ active: currentTab === index }"
                @click="currentTab = index">{{ tab.tabName + tab.videosLength }}</button>
      </div>

      <div>
        <input type="text" v-model="keyword" placeholder="リアルタイム検索">
        <select v-model="rateSelect">
          <option value=''>ランク</option>
          <option value=1>S</option>
          <option value=2>A</option>
          <option value=3>B</option>
          <option value=4>C</option>
        </select>
        <select v-model="mvpSelect">
          <option value=''>MOM</option>
          <option value=1>てつや</option>
          <option value=2>しばゆー</option>
          <option value=3>りょう</option>
          <option value=4>としみつ</option>
          <option value=5>ゆめまる</option>
          <option value=6>虫眼鏡</option>
        </select>
        <select v-model="categorySelect">
          <option value=''>カテゴリー</option>
          <option value=0>企画もの</option>
          <option value=1> サブチャン </option>
          <option value=2> コント </option>
          <option value=3> クイズ </option>
          <option value=4> 選手権 </option>
          <option value=5> 検証系 </option>
          <option value=6> 対決 </option>
          <option value=7> 王 </option>
          <option value=8> 文理対決 </option>
          <option value=9> 旅行 </option>
          <option value=10> 料理 </option>
          <option value=11> スポーツ </option>
          <option value=12> ドッキリ </option>
          <option value=13> ゲーム </option>
          <option value=14> コラボ </option>
          <option value=91> ニンマリシティへようこそ </option>
          <option value=92> ゆめまる美術館 </option>
          <option value=93> ブラーボりょうのボンサバドゥチャンネル </option>
          <option value=94> 虫眼鏡の放送部 </option>
          <option value=95> としみつ東海オンエアの </option>
          <option value=96> 動画アップロードチャンネル </option>
          <option value=97> 十字架(サブチャン) </option>
          <option value=98> いじわる </option>
          <option value=99> ごはんじゃんけん </option>
          <option value=90>その他</option>
        </select>

      </div>

      <div class="tab-content">
        <div v-show="currentTab === 0">
          <VideosArticles :videos="filteredvideos"></VideosArticles>
          <infinite-loading @infinite="infiniteHandler"></infinite-loading>  <!-- 無限スクロール -->
        </div>
        <div v-show="currentTab === 1">
          <VideosArticles :videos="mainvideos"></VideosArticles>
          <infinite-loading @infinite="infiniteHandler"></infinite-loading>  <!-- 無限スクロール -->
        </div>
        <div v-show="currentTab === 2">
          <VideosArticles :videos="subvideos"></VideosArticles>
          <infinite-loading @infinite="infiniteHandler"></infinite-loading>  <!-- 無限スクロール -->
        </div>
        <div v-show="currentTab === 3">
          <VideosArticles :videos="privatevideos"></VideosArticles>
          <infinite-loading @infinite="infiniteHandler"></infinite-loading>  <!-- 無限スクロール -->
        </div>
        <div v-show="currentTab === 4">
          <VideosArticles :videos="othervideos"></VideosArticles>
          <infinite-loading @infinite="infiniteHandler"></infinite-loading>  <!-- 無限スクロール -->
        </div>
      </div>
    </div>

  </div>
</template>

<script>
import axios from 'axios';
import VideosArticles from './VideosArticles.vue';
import SubscriberCounter from '../SubscriberCounter.vue';

export default {
  components: {
    VideosArticles,
    SubscriberCounter,
  },

  data: function () {
    return {
      keyword: '',
      rateSelect:'',
      mvpSelect: '',
      categorySelect: '',
      videos: [],
      count: [],
      page: 1,

      //タブ
      currentTab: 0,
      id: 0,
      tabName: "",
      tabs: [
        {id: 1, tabName: '全動画', videosLength: '0' },
        {id: 2, tabName: 'メイン', videosLength: '0'},
        {id: 3, tabName: '控え室', videosLength: '0'},
        {id: 4, tabName: '個チャン', videosLength: '0'},
        {id: 5, tabName: 'その他', videosLength: '0'}
      ],
    }
  },
  mounted () {
    axios
      .get('/api/v1/videos/count.json')
      .then(response => (this.count = response.data))
    },
  computed: {

    filteredvideos: function() { //検索機能
      var videos = [];

      for(var i in this.videos) {
        var video = this.videos[i];
        if(video.title.indexOf(this.keyword) !== -1 |
           video.description.indexOf(this.keyword) !== -1 |
           video.highlight.indexOf(this.keyword) !== -1 &&
           this.rateSelect == '' | video.rate == this.rateSelect &&
           this.mvpSelect  == '' | video.mvp  == this.mvpSelect &&
           this.categorySelect == '' | video.category == this.categorySelect
        ) {
            videos.push(video);
        }
      }
      console.log(videos);
      return videos;
    },

    mainvideos: function () {  //メインチャンネル
      var videos = this.filteredvideos;
      const mainvideos = videos.filter(video => video.kind_of == 0);
      this.tabs[0].videosLength = '(' + this.count.videos + ')'; //全動画の個数（入れるところが無かったのでここに）
      this.tabs[1].videosLength = '(' + this.count.main + ')';  //メインの個数
      return mainvideos;
    },  //mainvideos

    subvideos: function () {  //サブチャンネル
      var videos = this.filteredvideos;
      const subvideos = videos.filter(video => video.kind_of == 1);
      this.tabs[2].videosLength = '(' + this.count.sub + ')';  //サブの個数
      return subvideos;
    },  //subvideos

    privatevideos: function () {  //個人チャンネル
      var videos = this.filteredvideos;
      const privatevideos = videos.filter(video => video.kind_of == 2);
      this.tabs[3].videosLength = '(' + this.count.private + ')';  //個チャンの個数
      return privatevideos;
    },  //privatevideos

    othervideos: function () {  //その他のチャンネル
      var videos = this.filteredvideos;
      const othervideos = videos.filter(video => video.kind_of == 3);
      this.tabs[4].videosLength = '(' + this.count.other + ')';  //メインの個数
      return othervideos;
    },  //othervideos

  },  //computed

  methods: {
    infiniteHandler($state) {
        axios.get(`/api/v1/videos`, {
            params: {
                page: this.page,
            },
        }).then(({ data }) => {
            //そのままだと読み込み時にカクつくので1500毎に読み込む
            setTimeout(() => {
                if (this.page <=data.kaminari.pagenation.pages) {
                    this.page += 1
                    this.videos.push(...data.videos)
                    $state.loaded()
                } else {
                    $state.complete()
                }
            }, 800)
        }).catch((err) => {
            $state.complete()
        })
    }
  }

}  //export default
</script>

<style lang="scss" scoped>

input {
  margin: 0 0 10px 20px;
}

//  タブ  https://qiita.com/terufumi1122/items/16e7612a80f81f652000
.tabs {
  margin: 10px auto;
  padding: 10px;
  width: 100%;
  background: white;
  border-radius: 10px;
}
.btn-container {
  margin-bottom: 30px;
  display: flex;
  justify-content: center;
}
button {
  width: 19%;
  font-size: 20px;
  text-align: center;
  margin: 10px;
  padding: 3px 10px;
  background: white;
  border-radius: 10px;
  color: rgb(199, 199, 199);
  border: none;
}
button.active{
  background: rgb(255, 145, 0);
  color: white;
  border-color: white;
}
.tab-content div {
  background: #ffffff;
  width: 100%;
  margin: 0 auto;
}

</style>