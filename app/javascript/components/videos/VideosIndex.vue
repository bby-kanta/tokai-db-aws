<template>
  <div id="app">
    <input type="text" v-model="keyword">

    <div class="tabs">
      <div class="btn-container">
        <button v-for="(tab, index) in tabs"
                :key="tab.id"
                :class="{ active: currentTab === index }"
                @click="currentTab = index">{{ tab.tabName }}</button>
      </div>
      <div class="tab-content">
        <div v-show="currentTab === 0">
          <VideosArticles :videos="filteredvideos"></VideosArticles> 
        </div>
        <div v-show="currentTab === 1">
          <VideosArticles :videos="mainvideos"></VideosArticles>
        </div>
        <div v-show="currentTab === 2">
          <VideosArticles :videos="subvideos"></VideosArticles>
        </div>
        <div v-show="currentTab === 3">
          <VideosArticles :videos="privatevideos"></VideosArticles>
        </div>
        <div v-show="currentTab === 4">
          <VideosArticles :videos="othervideos"></VideosArticles>
        </div>
      </div>
    </div>

  </div>
</template>

<script>
import axios from 'axios';
import VideosArticles from './VideosArticles.vue';

export default {
  components: {
    VideosArticles
  },

  data: function () {
    return {
      keyword: '',
      videos: [],
      main: [],

      //タブ
      currentTab: 0,
      id: 0,
      tabName: "",
      tabs: [
        {id: 1, tabName: '全動画'},
        {id: 2, tabName: 'メインチャンネル'},
        {id: 3, tabName: '控え室'},
        {id: 4, tabName: '個人チャンネル'},
        {id: 5, tabName: 'その他'}
      ],
    }
  },
  mounted () {
    axios
      .get('/api/v1/videos.json')
      .then(response => (this.videos = response.data))
  },
  computed: {

    filteredvideos: function() { //検索機能

      var videos = [];

      for(var i in this.videos) {
        var video = this.videos[i];
        if(video.title.indexOf(this.keyword) !== -1) {
            videos.push(video);
        }
      }
      console.log(videos);
      return videos;
    },

    mainvideos: function () {  //メインチャンネル
      var videos = this.filteredvideos;
      const mainvideos = videos.filter(video => video.kind_of == 0);
      return mainvideos;
    },  //mainvideos

    subvideos: function () {  //サブチャンネル
      var videos = this.filteredvideos;
      const subvideos = videos.filter(video => video.kind_of == 1);
      return subvideos;
    },  //subvideos

    privatevideos: function () {  //個人チャンネル
      var videos = this.filteredvideos;
      const privatevideos = videos.filter(video => video.kind_of == 2);
      return privatevideos;
    },  //privatevideos

    othervideos: function () {  //その他のチャンネル
      var videos = this.filteredvideos;
      const othervideos = videos.filter(video => video.kind_of == 3);
      return othervideos;
    },  //othervideos

  }  //computed
}  //export default
</script>

<style lang="scss" scoped>

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