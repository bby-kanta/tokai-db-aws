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
      <h2> {{ youtube.items[0].statistics.viewCount + '回視聴'}} {{ video.updated_on }} に公開済み </h2>
      
      <a v-if="user == 1" :href=" '/videos/' + $route.params.id + '/edit#/' ">編集</a>
      <a v-if="user == 1" :href=" '/videos/' + $route.params.id ">管理用</a>

      <!-- ↓いいねボタン -->
      <i v-if="users_id().includes(user)" v-on:click="destroyFavorite" class="fas fa-heart" style="color:red"> {{ users_id().length }} </i>
      <a v-else-if="user == 'none'" href="users/sign_up">
        <i  class="far fa-heart"> {{ users_id().length }} </i>
      </a>
      <i v-else v-on:click="createFavorite" class="far fa-heart" > {{ users_id().length }} </i>


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
          <div  @click="top" class="highlight-content" v-html="video.highlight"></div>
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
            <a v-if="      video.kind_of == 0 " href="/videos/search?q%5Bkind_of_eq=0">メインチャンネル</a>
            <a v-else-if=" video.kind_of == 1 " href="/videos/search?q%5Bkind_of_eq=1">東海オンエアの控室</a>
            <a v-else-if=" video.kind_of == 2 " href="/videos/search?q%5Bkind_of_eq=2">個人チャンネル</a>
            <a v-else                           href="/videos/search?q%5Bkind_of_eq=3">その他のチャンネル</a>
          </div>
        </th>
      </tr>

      <tr>
        <th> カテゴリー </th>
        <th>   
          <div class="btn video-category">
            <a v-if=" video.category == 0 " href="/videos/search?q%5Bcategory_eq=0">企画もの</a>
            <a v-else-if=" video.category == 1 " href="/videos/search?q%5Bcategory_eq=1"> サブチャン </a>
            <a v-else-if=" video.category == 2 " href="/videos/search?q%5Bcategory_eq=2"> コント </a>
            <a v-else-if=" video.category == 3 " href="/videos/search?q%5Bcategory_eq=3"> クイズ </a>
            <a v-else-if=" video.category == 4 " href="/videos/search?q%5Bcategory_eq=4"> 選手権 </a>
            <a v-else-if=" video.category == 5 " href="/videos/search?q%5Bcategory_eq=5"> 検証系 </a>
            <a v-else-if=" video.category == 6 " href="/videos/search?q%5Bcategory_eq=6"> 対決 </a>
            <a v-else-if=" video.category == 7 " href="/videos/search?q%5Bcategory_eq=7"> 王 </a>
            <a v-else-if=" video.category == 8 " href="/videos/search?q%5Bcategory_eq=8"> 文理対決 </a>
            <a v-else-if=" video.category == 9 " href="/videos/search?q%5Bcategory_eq=9"> 旅行 </a>
            <a v-else-if=" video.category == 10 " href="/videos/search?q%5Bcategory_eq=10"> 料理 </a>
            <a v-else-if=" video.category == 11 " href="/videos/search?q%5Bcategory_eq=11"> スポーツ </a>
            <a v-else-if=" video.category == 12 " href="/videos/search?q%5Bcategory_eq=12"> ドッキリ </a>
            <a v-else-if=" video.category == 13 " href="/videos/search?q%5Bcategory_eq=13"> ゲーム </a>
            <a v-else-if=" video.category == 14 " href="/videos/search?q%5Bcategory_eq=14"> コラボ </a>
            <a v-else-if=" video.category == 91 " href="/videos/search?q%5Bcategory_eq=91"> ニンマリシティへようこそ </a>
            <a v-else-if=" video.category == 92 " href="/videos/search?q%5Bcategory_eq=92"> ゆめまる美術館 </a>
            <a v-else-if=" video.category == 93 " href="/videos/search?q%5Bcategory_eq=93"> ブラーボりょうのボンサバドゥチャンネル </a>
            <a v-else-if=" video.category == 94 " href="/videos/search?q%5Bcategory_eq=94"> 虫眼鏡の放送部 </a>
            <a v-else-if=" video.category == 95 " href="/videos/search?q%5Bcategory_eq=95"> としみつ東海オンエアの </a>
            <a v-else-if=" video.category == 96 " href="/videos/search?q%5Bcategory_eq=96"> 動画アップロードチャンネル </a>
            <a v-else-if=" video.category == 97 " href="/videos/search?q%5Bcategory_eq=97"> 十字架(サブチャン) </a>
            <a v-else-if=" video.category == 98 " href="/videos/search?q%5Bcategory_eq=98"> いじわる </a>
            <a v-else-if=" video.category == 99 " href="/videos/search?q%5Bcategory_eq=99"> ごはんじゃんけん </a>
            <a v-else                             href="/videos/search?q%5Bcategory_eq=90">その他</a>
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

      <tr>
        <th> 概要(本家) </th>
        <th>
          <div class="description-real" v-html="youtube.items[0].snippet.description">  </div>
        </th>
      </tr> 

    </table>

    <div class="comment-contents">
      <h2> {{ video.comments.length }} 件のコメント </h2>
      <form @submit="createComment">

        <div class="comment-form">
          <input v-model="comment.content" class="comment-box" type="text" placeholder="コメントを入力する">
          <div class="text_underline"></div>
        </div>

        <div class="comment-submit">
          <button type="submit"> コメント </button>
        </div>

      </form>

      <div class="comments">
        <div v-for="comment in video.comments" :key="comment.id" class="comment">
          <div class="comment-name">
            <img src="../../../assets/images/peace.jpg" width="30" height="30">
            <h2> {{ comment.user.name }} </h2>
            <i v-if="comment.user.id == user " @click="confirmDelete(), destroyComment(comment.id)" class="far fa-trash-alt"></i>
          </div>
          <div class="comment-text">
            <p> {{ comment.content }} </p>
          </div>
        </div>
      </div>

      <Adsense
          data-ad-client="ca-pub-6030549237323507"
          data-ad-slot="4196394214">
      </Adsense>

    </div>

  </div>

  <div class="related-videos">
    <VideosRecommend :videos="video.recommends"></VideosRecommend>
    <InFeedAdsense
      data-ad-layout-key="-6s+ed+2g-1n-4q"
      data-ad-client="ca-pub-6030549237323507"
      data-ad-slot="4173694552">
    </InFeedAdsense>
    <VideosRecommend></VideosRecommend>
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
      video: {
        comments: '',  //これがないとコンソールに一瞬lengthが定義されてない的なエラーが出る（実害は無し）
      },
      videos: {},
      user: {},
      favorite: {},
      comment: {
        content: "",
      },
      youtube: {
        items: [{
          snippet: {
            description: "",
          },
          statistics: {
            viewCount: '',
          }
        }]
      },
    }

  },

  mounted () {
    axios
      .get('/api/v1/users.json')
      .then(response => (this.user = response.data)) 
  },

  watch: {
    $route (to, from) {
      this.fetchVideos(to.params.id)
      },
  },

  computed: {

  },

  methods: {

    async fetchVideos(id) {
      await axios
      .get(`/api/v1/videos/${this.$route.params.id}.json`)
      .then(response => (this.video = response.data))
      axios  //いいね更新用
        .get('/api/v1/favorites.json')
        .then(response => (this.favorite = response.data))
      await
      axios.get(`https://www.googleapis.com/youtube/v3/videos?id=${this.video.url}&key=AIzaSyDovZVx44zT7JglmnHzWoeUeXDrQra4CVg&part=snippet,statistics`)
      .then(response => (this.youtube = response.data))
      console.log(this.youtube)
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

    createComment: function() {
      axios
        .post('/api/v1/comments',{ content: this.comment.content ,video_id: this.video.id} );
      this.fetchVideos(this.video.id);
      // this.$router.go({path: this.$router.currentRoute.path, force: true})
    },

    destroyComment(comment_id) {
      const comment = comment_id
      console.log('コメントID'+comment+'を消します')
      axios.delete(`/api/v1/comments/${comment}`);
      // this.fetchVideos(this.video.id);
      this.$router.go({path: this.$router.currentRoute.path, force: true})
    },

    confirmDelete(){
      const ans = confirm('本当に消しますか?'); 
      if(!ans) event.preventDefault(); // 「キャンセル」押下ならば event を抑制
    },

    top() {

      const duration = 200;  // 移動速度（0.2秒で終了）
      const interval = 10;    // 0.01秒ごとに移動
      const step = -window.scrollY / Math.ceil(duration / interval); // 1回に移動する距離
      const timer = setInterval(() => {
          window.scrollBy(0, step);   // スクロール位置を移動
          if(window.scrollY <= 0) {
              clearInterval(timer);
          }
      }, interval);
    }

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

  .description-real {
    white-space: pre-line;  //本家の概要に改行を許可する
  }

  .comment-contents {  //コメント関連  https://qiita.com/KengoShimizu/items/22c14b282fa9f53f4bd8
    width: 100%;
    margin-top: 40px;
    .comment-form {  //コメントの入力フォーム
      margin-top: 30px;

      .comment-box {
        font-size: 16px;
        width: 100%;
        border: none;
        outline: none;
        padding-bottom: 8px;
        box-sizing: border-box; /*横幅の解釈をpadding, borderまでとする*/
      }
      .text_underline{
        position: relative; /*.text_underline::beforeの親要素*/
        border-top: 3px solid #c2c2c2; /*text3の下線*/
      }

      .text_underline::before,
      .text_underline::after{
          position: absolute; 
          bottom: 0px; /*中央配置*/
          width: 0px; /*アニメーションで0pxから50%に*/
          height: 3px; /*高さ*/
          content: '';
          background-color: #ff8c00; /*アニメーションの色*/
          transition: all 0.5s;
          -webkit-transition: all 0.5s;
      }

      /*中央から右へのアニメーション*/
      .text_underline::before{
          left: 50%; /*中央配置*/
      }

      /*中央から左へのアニメーション*/
      .text_underline::after{ 
          right: 50%; /*中央配置*/
      }

      .comment-box:focus + .text_underline::before,
      .comment-box:focus + .text_underline::after{
          width: 50%;
      }
    }
    .comment-submit {
      margin-top: 10px;
      display: flex;
      flex-direction: row-reverse;
      button {
        position: relative;
        display: inline-block;
        padding: 0.25em 0.5em;
        text-decoration: none;
        color: #FFF;
        background: #fd9535;/*背景色*/
        border-bottom: solid 2px #d27d00;/*少し濃い目の色に*/
        border-radius: 4px;/*角の丸み*/
        box-shadow: inset 0 2px 0 rgba(255,255,255,0.2), 0 2px 2px rgba(0, 0, 0, 0.19);
        font-weight: bold;
      }
    }
    .comments {
      margin: 20px 0;
      .comment:hover {
        border-bottom: 2px solid #ff8c00;
      }
      .comment {
        margin: 20px 0;
        padding-bottom: 10px;
        border-bottom: 2px solid #c2c2c2;
        .comment-name {
          margin-bottom: 10px;
          display:flex;
          align-items: center;
          h2 {
            margin: 0 10px;
          }
          img {
            border-radius: 50%;
            border: 1px solid rgb(53, 53, 53);
          }
          i:before, i:before {
            cursor: pointer;
          }
        }
        .comment-text {
          p {
            margin-left: 40px;
          }
        }
      }
    }
  }

@media screen and (min-width: 1000px){
  .related-videos {
    width: 400px;
    .video-article_show {
      width: 100%;
    }
  }

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