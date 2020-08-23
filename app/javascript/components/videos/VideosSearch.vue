<template>
  <div id="search-videos-index">

    <div class="title">
      <h3>{{videos.length}}件の記事が見つかりました</h3>
    </div>

    <div class="video_articles">
      <div class="video_article" v-for="video in videos" :key="video.id">
        <a :href="'/#/videos/' + video.id ">  <!-- 少々強引だけどSPAに合流させる -->

          <div v-if="video.kind_of == 0" class="article-kind_of btn tetsuya">メイン</div>
          <div v-if="video.kind_of == 1" class="article-kind_of btn toshimitsu">控え室</div>
          <div v-if="video.kind_of == 2" class="article-kind_of btn ryo">個チャン</div>
          <div v-if="video.kind_of == 3" class="article-kind_of btn yumemaru">その他</div>

          <div class="article-image">
            <img :src="'https://img.youtube.com/vi/' + video.url + '/maxresdefault.jpg'">
          </div>

          <div class="article-column">
            <div class="article-title">
              <p class="article_title">{{video.title}}</p>
            </div>

            <div class="article_row">

              <div class="article-rate" v-if="video.rate == 1">
                <h3 class="S"> S </h3>
              </div>
              <div class="article-rate" v-else-if="video.rate == 2">
                <h3 class="A"> A </h3> 
              </div>
              <div class="article-rate" v-else-if="video.rate == 3">
                <h3 class="B"> B </h3> 
              </div>
              <div class="article-rate" v-else>
                <h3 class="C"> C </h3> 
              </div>

              <div class="article-mvp">
                <h3 v-if="video.mvp      == 1" class="tetsuya">てつや</h3>
                <h3 v-else-if="video.mvp == 2" class="shibayu">しばゆー</h3>
                <h3 v-else-if="video.mvp == 3" class="ryo">りょう</h3>
                <h3 v-else-if="video.mvp == 4" class="toshimitsu">としみつ</h3>
                <h3 v-else-if="video.mvp == 5" class="yumemaru">ゆめまる</h3>
                <h3 v-else-if="video.mvp == 6" class="mushimegane">虫眼鏡</h3>
                <h3 v-else class="tokai">該当無し</h3>
              </div>
              
              <div class="article-tags" >
                  <div class="article-tag btn" v-for="tag in video.random_tags" :key="tag.id">
                    <h3>{{ tag.name }}</h3>
                  </div>
              </div>

            </div>


          </div>
          <div class="article-date">
            {{ video.updated_on }}
            <div id="like-">
              <i v-if="users_id(video.users).includes(user)" class="fas fa-heart" style="color:red"> {{ video.users.length }} </i>
              <i v-else class="far fa-heart"> {{ video.users.length }} </i>
            </div>
          </div>

        </a>
      </div>
    </div>

  </div>
</template>

<script>
import axios from 'axios';

export default {

  name: 'VideosSearch',

  data: function () {
    return {
      user: {},  //current_userのID
    }
  },

  props: {
    videos: {
      type: Array,
      required: true
    },

  },

  mounted () {
    axios  //currentuserのID
      .get('/api/v1/users.json')
      .then(response => (this.user = response.data))
  },

  methods: {
    users_id(users) { //users_idにはvideoのusersのidがシンプルな配列で入る→ 連想配列では無くなったのでincludesメソッドが使える
      var user = this.user;
      var users_id = [];
      var hoge = [];

      for(hoge in users){
        users_id.push(users[hoge].id);  //例）users_id = [1,2]
      }
      return users_id 
    },
  },

  computed: {

  }  //computed
}  //export default
</script>

<style lang="scss" scoped>

.article-kind_of {
  position: absolute;
  z-index: 10;
  margin: 9px 0 0 10px;
  border-radius: 20px;
}

.video_articles {
  margin-top: 20px;
}

.video_article {
  box-shadow: 2px 2px 4px gray;
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