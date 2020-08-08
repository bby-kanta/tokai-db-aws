<template>

<div class="all-contents">

  <div class="video_box">
    <div class="video-youtube">
      <iframe name="player" width="100%" height="100%" :src="'https://www.youtube.com/embed/' + video.url + '?autoplay=1&loop=1&playlist=' + video.url " frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
    </div>

    <div class="video_title">
      <h3> {{ video.title }} </h3>
    </div>

    <div class="video_date">
      <h2> {{ video.updated_on }} に公開済み </h2>
      
      <a v-if="user == 1" :href=" '/videos/' + $route.params.id + '/edit#/' ">編集</a>

      <!-- ↓いいねボタン -->
      <i v-if="users_id.includes(user)" v-on:click="destroyFavorite" class="fas fa-heart" style="color:red"> {{ users_id.length }} </i>

      <a v-else-if="user == 'none'" href="users/sign_up">
        <i  class="far fa-heart"> {{ users_id.length }} </i>
      </a>

      <i v-else v-on:click="createFavorite" class="far fa-heart" > {{ users_id.length }} </i>


    </div>

    <table border="1px" style="border-collapse: collapse; border-color: rgb(238, 232, 232)">

      <tr class="video-description">
        <th> 概要 </th>
        <th>   
          <p> {{ video.description }} </p>
        </th>
      </tr>

      <tr class="video-highlight">
        <th> 見所 </th>
        <th>   
          <div class="highlight-content" v-html="video.highlight"></div>
        </th>
      </tr>

      <tr class="video-quotes">
        <th> 名言 </th>
        <th>   
          <p> {{ video.quotes}} </p>
        </th>
      </tr>

      <tr>
        <th> ランク </th>
        <th>
          <div class="video-rate">
            <h3 v-if="      video.rate == 1 " class="S"> S </h3>
            <h3 v-else-if=" video.rate == 2 " class="A"> A </h3>
            <h3 v-else-if=" video.rate == 3 " class="B"> B </h3>
            <h3 v-else                        class="C"> C </h3>
          </div>
        </th>
      </tr>

      <tr class="video_kind_of">
        <th> チャンネル種類 </th>
        <th>
          <div class="btn channel">
            <a v-if="      video.kind_of == 0 ">メインチャンネル</a>
            <a v-else-if=" video.kind_of == 1 ">東海オンエアの控室</a>
            <a v-else-if=" video.kind_of == 2 ">個人チャンネル</a>
            <a v-else                          >その他のチャンネル</a>

            <!-- <% case @video.kind_of %>
              <% when 0 %>
                <%= link_to "メインチャンネル", search_videos_path(@search, :'q[kind_of_eq' => 0 ) %>
              <% when 1 %>
                <%= link_to "東海オンエアの控え室", search_videos_path(@search, :'q[kind_of_eq' => 1 ) %>
              <% when 2 %>
                <%= link_to "個人チャンネル", search_videos_path(@search, :'q[kind_of_eq' => 2 ) %>
              <% else %>
                <%= link_to "その他のチャンネル", search_videos_path(@search, :'q[kind_of_eq' => 3 ) %>
            <% end %> -->
          </div>
        </th>
      </tr>

      <tr>
        <th> カテゴリー </th>
        <th>   
          <div class="btn video-category">
            <a v-if=" video.category == 0 ">企画もの</a>
            <a v-else-if=" video.category == 1 "> サブチャン </a>
            <a v-else-if=" video.category == 2 "> コント </a>
            <a v-else-if=" video.category == 3 "> クイズ </a>
            <a v-else-if=" video.category == 4 "> 選手権 </a>
            <a v-else-if=" video.category == 5 "> 検証系 </a>
            <a v-else-if=" video.category == 6 "> 対決 </a>
            <a v-else-if=" video.category == 7 "> 王 </a>
            <a v-else-if=" video.category == 8 "> 文理対決 </a>
            <a v-else-if=" video.category == 9 "> 旅行 </a>
            <a v-else-if=" video.category == 10 "> 料理 </a>
            <a v-else-if=" video.category == 11 "> スポーツ </a>
            <a v-else-if=" video.category == 12 "> ドッキリ </a>
            <a v-else-if=" video.category == 13 "> ゲーム </a>
            <a v-else-if=" video.category == 14 "> コラボ </a>
            <a v-else-if=" video.category == 91 "> ニンマリシティへようこそ </a>
            <a v-else-if=" video.category == 92 "> ゆめまる美術館 </a>
            <a v-else-if=" video.category == 93 "> ブラーボりょうのボンサバドゥチャンネル </a>
            <a v-else-if=" video.category == 94 "> 虫眼鏡の放送部 </a>
            <a v-else-if=" video.category == 95 "> としみつ東海オンエアの </a>
            <a v-else-if=" video.category == 96 "> 動画アップロードチャンネル </a>
            <a v-else-if=" video.category == 97 "> 十字架(サブチャン) </a>
            <a v-else-if=" video.category == 98 "> いじわる </a>
            <a v-else-if=" video.category == 99 "> ごはんじゃんけん </a>
            <a v-else                          >その他</a>
          </div>
        </th>
      </tr>

      <tr>
        <th> 登場メンバー </th>
        <th>
          <div class="video-people">
            <div class="person" v-for="person in video.people" :key="person.id">
              <VideosPersonColor :person="person.id" :person_name="person.name"></VideosPersonColor>
            </div>
          </div>
        </th>
      </tr>

      <tr class="video-mvp">
        <th> マンオブザマッチ </th>
        <th>
          <div class="video-person-mvp">
              <VideosPersonColor :person="video.mvp"></VideosPersonColor>
          </div>
        </th>
      </tr>

      <tr>
        <th> 編集者 </th>
        <th>
          <div class="video-person-editor">
              <VideosPersonColor :person="video.editor"></VideosPersonColor>
          </div>
        </th>
      </tr>

      <tr>
        <th> 撮影場所 </th>
        <th>
          <div class="places">
            <div class="btn btn-danger place" v-for="place in video.places" :key="place.id">
              <router-link :to="{ name: 'PlacesShow', params: { id: place.id } }" >
                {{ place.name }}
              </router-link>
            </div>
          </div>
        </th>
      </tr>

      <tr>
        <th> BGM </th>
        <th>
          <div class="musics">
              <div class="btn btn-success music" v-for="music in video.musics" :key="music.id">
                  <router-link :to="{ name: 'MusicsShow', params: { id: music.id } }" >
                    {{ music.name }}
                  </router-link>
              </div>
          </div>
        </th>
      </tr>

      <tr>
        <th> 罰ゲーム </th>
        <th>
          <div class="penalties">
            <div class="penalty" v-for="penalty in video.penalties" :key="penalty.id">
              <PenaltyColor :person="penalty.person_id" :penalty_id="penalty.id" :penalty_name="penalty.name"></PenaltyColor>
            </div>
          </div>
        </th>
      </tr>

    
      <tr>
        <th> ハッシュタグ </th>
        <th> 
          <div class="tags">
            <div class="tag" v-for="tag in video.tags" :key="tag.id">
              <TagColor :person="tag.person_id" :tag_id="tag.id" :tag_name="tag.name"></TagColor>
            </div>
          </div>
        </th>
      </tr> 

    </table>

  </div>

  <div class="related-videos">
    <VideosRecommend :videos="video.recommends"></VideosRecommend>
    <VideosRecommend :videos="random(videos, 8)"></VideosRecommend>
  </div>


</div>


</template>

<script>
import axios from 'axios';

import VideosRecommend   from './VideosRecommend.vue';
import VideosPersonColor from './VideosPersonColor.vue';
import PenaltyColor from '../PenaltyColor.vue';
import TagColor from '../TagColor.vue';

export default {
  components: {
    VideosRecommend,
    VideosPersonColor,
    PenaltyColor,
    TagColor,
  },

  created() {
    this.fetchVideos(this.$route.params.id)
  },

  data: function () {
    return {
      video: {},
      videos: {},
      user: {},
      favorite: {},
    }

  },

  mounted () {
    axios
      .get('/api/v1/videos.json')
      .then(response => (this.videos = response.data))

    axios
      .get('/api/v1/users.json')
      .then(response => (this.user = response.data))
  },

  watch: {
    $route (to, from) {
      // this.$router.go({ name: 'VideosShow' })
      this.fetchVideos(to.params.id)
      },
  },

  computed: {
    users_id: function() { //users_idにはvideoのusersのidがシンプルな配列で入る→ 連想配列では無くなったのでincludesメソッドが使える
      var users = this.video.users;  //例）"video.users":[{"id":1},{"id":2}]
      var user = this.user;
      var users_id = [];
      var hoge = [];

      for(hoge in users){
        users_id.push(users[hoge].id);  //例）users_id = [1,2]
      }

      // console.log(users_id);
      // console.log(users_id.includes(user));
      return users_id 
    },
  },

  methods: {

    fetchVideos(id) {
      axios
      .get(`/api/v1/videos/${this.$route.params.id}.json`)
      .then(response => (this.video = response.data))
      axios  //いいね更新用
        .get('/api/v1/favorites.json')
        .then(response => (this.favorite = response.data))
    },

    random(array, num) {  //配列から特定の数だけ取り出すメソッド
      var a = array;
      var t = [];
      var r = [];
      var l = a.length;
      var n = num < l ? num : l;
      while (n-- > 0) {
        var i = Math.random() * l | 0;
        r[n] = t[i] || a[i];
        --l;
        t[i] = t[l] || a[l];
      }
      return r;
    },

    createFavorite: async function() {  //https://qiita.com/TakeshiFukushima/items/a6c698fec648c11eee9a
       await axios.post('/api/v1/favorites',{video_id: this.video.id , user_id: this.user.id})
       this.fetchVideos(this.video.id)
    },

    destroyFavorite: async function() {
      const likeId = this.findLikeId();
       axios.delete(`/api/v1/favorites/${likeId}`);
      this.fetchVideos(this.video.id);
    },

    findLikeId: function() {
      const like = this.favorite.find((like) => {
        return (like.user_id === this.user & like.video_id === this.video.id)
      })
      if (like) { return like.id }
    },

  }  //methods
}
</script>

<style lang="scss" scoped>

  .video-people , .penalties , .tags {
    display: flex;
    flex-wrap: wrap;
  }

  .person , .penalty , .tag , .place , .music {
    margin: 0 3px 3px 0;
  }

@media screen and (max-width: 999px){ /*widthが999pxまでのCSS(スマホ用)*/

  .all-contents {
    flex-direction: column;
  }

  .related-videos {
    width: 100%;
    .video-article_show {
      width: 100%;
    }
  }

  .main-contents {
    margin : 0;
  }

  .video_box{
    width : 100%;
  }

  .video-youtube { /*動画を固定表示する*/
    position: fixed;
    z-index: 999;
    top : 1;
    left: 0;
  }
  .video_title { /*タイトルが下に入って重ならない用*/
    margin-top: 590px;
  }

  .video-description {
    th {

      p {
        font-size: 25px;
      }
    }
  }

  .highlight-content {
    a {
      font-size: 30px;
      margin-bottom: 20px;
    }
  }

}

.video_date {
  .fa-heart {
    margin: 20px 0;
    font-size: 30px;
    cursor: pointer;
  }
}



</style>