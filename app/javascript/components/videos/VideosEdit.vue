<template>

<div class="all-contents" v-if="user == 1">
  <div class="video_box">
    <div class="video-youtube">
      <iframe name="player" width="100%" height="100%" :src="'https://www.youtube.com/embed/' + video.url + '?autoplay=1&loop=1&playlist=' + video.url " frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
    </div>

    <div class="video_title">
      <div class="mb-2">
        <div class="minutes-to-second">
          <input v-model="minutes" type="number" min="0">分
          <input v-model="seconds" type="number" min="0" max="60">秒 →
          {{minutesToseconds}}秒です！
        </div>
        <div class="second-button mt-3">
          <button @click="seconds = 0">0秒</button>
          <button @click="seconds = 10">10秒</button>
          <button @click="seconds = 20">20秒</button>
          <button @click="seconds = 30">30秒</button>
          <button @click="seconds = 40">40秒</button>
          <button @click="seconds = 50">50秒</button>
        </div>
      </div>
      <h3> {{ video.title }} </h3>
      <router-link :to="{ name: 'VideosShow', params: { id: video.id } }">showページへ移動</router-link>
      <a :href="'/videos/' + video.id + '/edit'">編集</a>
    </div>

    <div class="video_date">
      <h2>{{ video.updated_on }} に公開済み</h2>
    </div>

    <table border="1px" style="border-collapse: collapse; border-color: rgb(238, 232, 232)">

      <tr class="video-highlight">
        <th> 見所 </th>
        <th>
          <div @click="top" class="highlight-content" v-html="video.highlight"></div>
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

          <div class="text_line" v-if="user != 'none'"></div>
          <h2 class="mt-3 mb-3" v-if="user != 'none'">あなたが作ったハッシュタグリスト</h2>
          <input type="text" v-model="tagKeyword" placeholder="ハッシュタグ検索" class="mb-2">
          <div class="tags">
            <div v-for="tag in filteredtags" :key="tag.id">
              <div v-if="tags_id().includes(tag.id)" @click="destroyVideoTag(tag.id)" class="btn red-black tag">
                {{ tag.name }}
              </div>
              <div v-else @click="createVideoTag(tag.id)" class="btn red tag">
                {{ tag.name }}
              </div>
            </div>
          </div>

        </th>
      </tr>

      <tr class="video-description">
        <th> 投稿日 </th>
        <th>   
          <p> {{ video.updated_on }} </p>
        </th>
      </tr>

      <tr class="video-description">
        <th> 概要 </th>
        <th>
          <textarea v-model="video.description" cols="30" rows="10"></textarea>
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

          <div class="text_line" v-if="user != 'none'"></div>

          <h2 @click="fetchMusics()" class="mt-3 mb-3 blue" v-if="user != 'none' && musics.length == null">BGMを紐付ける</h2>
          <h2 v-if="musics.length" class="mt-3 mb-3">BGMリスト</h2>
          <input v-if="musics.length" type="text" v-model="musicKeyword" placeholder="BGM検索" class="mb-2">

          <div class="musics">
            <div v-for="music in filteredmusics" :key="music.id">
              <div v-if="musics_id().includes(music.id)" @click="destroyVideoMusic(music.id)" class="btn red-black tag">
                {{ music.name }}
              </div>
              <div v-else @click="createVideoMusic(music.id)" class="btn red tag">
                {{ music.name }}
              </div>
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

    </table>

  </div>

  <div class="related-videos">
    <div class="update-video">
        <div class="comment-form">
          <textarea v-model="video.highlight" class="" placeholder="見所を入力する"></textarea>
        </div>

        <div>
          <input v-model="youtube.items[0].snippet.publishedAt" class="comment-box" type="date">
          公開日を{{ youtube.items[0].snippet.publishedAt }}に更新する。
        </div>

        <div class="comment-submit">
          <button @click="UpdateVideo()">更新</button>
        </div>
    </div>

    <div class="tabs">
      <div class="btn-container">
        <button v-for="(tab, index) in tabs"
                :key="tab.id"
                :class="{ active: currentTab === index }"
                @click="currentTab = index">{{ tab.tabName }}</button>
      </div>

      <div class="tab-content">
        <div v-show="currentTab === 0">
          <div class="tag-form">
              <h2>ハッシュタグを作る</h2>
              <div class="comment-form">
                <select v-model="tag.person_id">
                  <option value=''>人物名</option>
                  <option value=1>てつや</option>
                  <option value=2>しばゆー</option>
                  <option value=3>りょう</option>
                  <option value=4>としみつ</option>
                  <option value=5>ゆめまる</option>
                  <option value=6>虫眼鏡</option>
                  <option value=7>共通タグ</option>
                </select>
                <input v-model="tag.name" class="comment-box" type="text" placeholder="タグ名を入力する">
                <input v-model="tag.sort" class="comment-box" type="text" placeholder="ふりがなを入力する">
                <textarea v-model="tag.description" class="" placeholder="概要を入力する"></textarea>
              </div>
              <div class="comment-submit">
                <button @click="createTag()">作成</button>
              </div>
          </div>
        </div>
        <div v-show="currentTab === 1">
          <div class="tag-form">
              <h2>罰ゲームを作る</h2>
              <div class="comment-form">
                <select v-model="penalty.person_id">
                  <option value=''>人物名</option>
                  <option value=1>てつや</option>
                  <option value=2>しばゆー</option>
                  <option value=3>りょう</option>
                  <option value=4>としみつ</option>
                  <option value=5>ゆめまる</option>
                  <option value=6>虫眼鏡</option>
                </select>
                <input v-model="penalty.name" class="comment-box" type="text" placeholder="罰ゲーム名を入力する">
                <input v-model="penalty.sort" class="comment-box" type="text" placeholder="ふりがなを入力する">
                <input v-model="penalty.since" class="comment-box" type="date" placeholder="ふりがなを入力する">
                <textarea v-model="penalty.description" class="" placeholder="概要を入力する"></textarea>
              </div>
              <div class="comment-submit">
                <button @click="createPenalty()">作成</button>
              </div>
          </div>
        </div>
        <div v-show="currentTab === 2">
          <div class="tag-form">
              <h2>撮影場所を作る</h2>
              <div class="comment-form">
                <input v-model="place.name" class="comment-box" type="text" placeholder="場所の名前を入力する">
                <textarea v-model="place.description" class="" placeholder="概要を入力する"></textarea>
              </div>
              <div class="comment-submit">
                <button @click="createPlace()">作成</button>
              </div>
          </div>
        </div>
        <div v-show="currentTab === 3">
          <div class="tag-form">
            <h2 @click="fetchMusics()" v-if="musics.length == null" class="blue">BGM一覧を表示する</h2>
            <select v-model="music.url" v-if="musics.length != null">
                <option value="">選択して下さい</option>
                <option v-for="bgm in musics" :key="bgm.id" :value="bgm.url">
                  {{ bgm.name }}
                </option>
            </select>

            <div class="video-youtube">
              <iframe name="player" width="100%" height="100%" :src="'https://www.youtube.com/embed/' + music.url + '?autoplay=1&loop=1&playlist=' + music.url " frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
            </div>

            <h2>BGMを作る</h2>
            <div class="comment-form">
              <input v-model="music.name" class="comment-box" type="text" placeholder="BGM名を入力する">
              <input v-model="music.url" class="comment-box" type="text" placeholder="動画コードを入力する">
              <textarea v-model="music.description" class="" placeholder="概要を入力する"></textarea>
            </div>
            <div class="comment-submit">
              <button @click="createMusic()">作成</button>
            </div>

          </div>
        </div>
        <div v-show="currentTab === 4">
          <div class="tag-form">
              <h2>出演者タグを作る</h2>
              <div class="comment-form">
                <input v-model="person.name" class="comment-box" type="text" placeholder="出演者の名前を入力する">
                <textarea v-model="person.description" class="" placeholder="概要を入力する"></textarea>
              </div>
              <div class="comment-submit">
                <button @click="createPerson()">作成</button>
              </div>
          </div>
        </div>
        <div v-show="currentTab === 5">
          <div class="tag-form">
              <h2 @click="fetchAllVideos()" v-if="videos.length == null" class="blue">関連動画を紐付ける</h2>
              <input type="text" v-model="keyword" v-if="videos.length != null" placeholder="タイトル検索">
              <select v-model="select" v-if="videos.length != null">
                <option value=""></option>
                <option value='1'>既に紐付けられている動画</option>
              </select>
              <div v-for="video in filteredvideos" :key="video.id">
                <div v-if="recommend_id.includes(video.id)" @click="destroyRelationship(video.id)" class="pointer">
                  {{ video.title }}
                </div>
                <div v-else @click="createRelationship(video.id)" class="blue">
                  {{ video.title }}
                </div>
              </div>
          </div>
        </div>
      </div>
    </div>


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
    this.fetchVideos(this.$route.params.id);
  },

  data: function () {
    return {
      video: {
        highlight: '',
        description: '',
        updated_on: '',
        tags: {},
        musics: {},
      },
      videos: {},
      userTags: {},
      tagVideos: {},
      musicVideos: {},
      relationships: {},
      keyword: '',
      tagKeyword: '',
      musicKeyword: '',
      select: '',
      user: {},
      minutes: '',
      seconds: '',
      // ハッシュタグ
      tag: {
        name: "",
        sort: "",
        description: "",
        person_id: "",
      },
      // 罰ゲーム
      penalty: {
        name: "",
        sort: "",
        description: "",
        person_id: "",
        since: "",
      },
      //撮影場所
      place: {
        name: "",
        description: "",
      },
      //BGM
      musics: {},
      music: {
        name: "",
        description: "",
        url: ""
      },
      //出演者
      person: {
        name: "",
        description: "",
      },
      //タブ
      currentTab: 0,
      id: 0,
      tabName: "",
      tabs: [
        {id: 1, tabName: 'タグ'},
        {id: 2, tabName: '罰ゲーム'},
        {id: 3, tabName: '撮影場所'},
        {id: 4, tabName: 'BGM'},
        {id: 5, tabName: '人物'},
        {id: 6, tabName: '関連動画'}
      ],
      youtube: {
        items: [{
          snippet: {
            description: "",
            publishedAt: "",
          },
          statistics: {
            viewCount: '',
          }
        }]
      },
    }

  },

  async mounted () {
    await axios
    .get('/api/v1/users.json')
    .then(response => (this.user = response.data));
  },

  watch: {
    $route (to, from) {
      this.fetchVideos(to.params.id)
      },
  },

  computed: {
    minutesToseconds: function() { //分数を秒数に変換する
      const cpMinutes = Number(this.minutes * 60);
      const seconds   = Number(this.seconds);
      const cpSeconds = cpMinutes + seconds;
      return cpSeconds;
    },
    filteredvideos: function() { //検索機能
      var videos = [];

      for(var i in this.videos) {
        var video = this.videos[i];
        if(video.title.indexOf(this.keyword) !== -1 |
           video.sort.indexOf(this.keyword) !== -1 &&
           this.select == "" | this.recommend_id.includes(video.id)
        ) {
            videos.push(video);
        }
      }
      return videos;
    },
    filteredtags: function() { //検索機能
      var tags = [];

      for(var i in this.userTags) {
        var tag = this.userTags[i];
        if(tag.name.indexOf(this.tagKeyword) !== -1 |
           tag.sort.indexOf(this.tagKeyword) !== -1
        ) {
            tags.push(tag);
        }
      }
      return tags;
    },
    filteredmusics: function() { //検索機能
      var musics = [];

      for(var i in this.musics) {
        var music = this.musics[i];
        if(music.name.indexOf(this.musicKeyword) !== -1
        ) {
            musics.push(music);
        }
      }
      return musics;
    },
    recommend_id: function() {
      var recommends = this.video.recommends;  //例）"video.recommend":[{"id":1},{"id":2}]
      var recommend_id = [];
      var hoge = [];

      for(hoge in recommends){
        recommend_id.push(recommends[hoge].id);  //例）recommend_id = [1,2]
      }
      return recommend_id 
    },
    
  },

  methods: {

    async fetchVideos(id) {
      await axios
      .get(`/api/v1/videos/${this.$route.params.id}.json`)
      .then(response => (this.video = response.data))
      await axios  //tag_videos更新用
        .get(`/api/v1/tag_videos/${this.$route.params.id}.json`)
        .then(response => (this.tagVideos = response.data))
      await axios  //music_videos更新用
        .get(`/api/v1/music_videos/${this.$route.params.id}.json`)
        .then(response => (this.musicVideos = response.data))
      await axios
        .get(`/api/v1/relationships.json`)
        .then(response => (this.relationships = response.data))
      if (this.user != 'none') {
        await axios
          .get(`/api/v1/users/${this.user}`)
          .then(response => (this.userTags = response.data.tags))
      await axios
      .get(`https://www.googleapis.com/youtube/v3/videos?id=${this.video.url}&key=AIzaSyBCXbm3lqPhpyJN0OR2Z_kH-GoLTW-Ulps&part=snippet,statistics`)
      .then(response => (this.youtube = response.data))
      }
    },

    createTag: async function() {
      await axios
        .post('/api/v1/tags',{ name: this.tag.name , sort: this.tag.sort, description: this.tag.description ,person_id: this.tag.person_id} );
      await axios
        .get(`/api/v1/users/${this.user}`)
        .then(response => (this.userTags = response.data.tags))
      this.tag.name = ""
      this.tag.sort = ""
      this.tag.description = ""
      this.tag.person_id = ""
    },

    createPenalty: async function() {
      await axios
        .post('/api/v1/penalties',{ name: this.penalty.name , sort: this.penalty.sort, description: this.penalty.description ,person_id: this.penalty.person_id, since: this.penalty.since} );
      this.penalty.name = ""
      this.penalty.sort = ""
      this.penalty.description = ""
      this.penalty.person_id = ""
      this.penalty.since = ""
    },

    createPlace: async function() {
      await axios
        .post('/api/v1/places',{ name: this.place.name, description: this.place.description } );
      this.place.name = ""
      this.place.description = ""
    },

    createMusic: async function() {
      await axios
        .post('/api/v1/musics',{ name: this.music.name, description: this.music.description, url: this.music.url } );
      this.fetchMusics()
      this.music.name = ""
      this.music.description = ""
      this.music.url = ""
    },

    createPerson: async function() {
      await axios
        .post('/api/v1/people',{ name: this.person.name, description: this.person.description } );
      this.person.name = ""
      this.person.description = ""
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
    },

    UpdateVideo: async function() {
      await axios
        .put(`/api/v1/videos/${this.video.id}`,{ highlight: this.video.highlight, description: this.video.description, updated_on: this.youtube.items[0].snippet.publishedAt} );
      this.fetchVideos(this.video.id);
    },

    async createVideoTag(id) {
      await axios
      .post('/api/v1/tag_videos',{video_id: this.video.id , tag_id: id})
      await axios  //tag_videos更新用
        .get(`/api/v1/tag_videos/${this.$route.params.id}.json`)
        .then(response => (this.tagVideos = response.data))
      await axios
        .get(`/api/v1/videos/${this.$route.params.id}.json`)
        .then(response => (this.video.tags = response.data.tags))
    },
    async destroyVideoTag(VideoTag_id) {
      const videoTagId = this.findVideoTagId(VideoTag_id);
      await axios
        .delete(`/api/v1/tag_videos/${videoTagId}`);
      await axios  //tag_videos更新用
        .get(`/api/v1/tag_videos/${this.$route.params.id}.json`)
        .then(response => (this.tagVideos = response.data))
      await axios
        .get(`/api/v1/videos/${this.$route.params.id}.json`)
        .then(response => (this.video.tags = response.data.tags))
    },
    findVideoTagId(tagid) {
      const tag = this.tagVideos.find((tag) => {
        return (tag.tag_id === tagid)
      })
      if (tag) { return tag.id }
    },

    async createVideoMusic(musicId) {
      await axios
      .post('/api/v1/music_videos',{video_id: this.video.id , music_id: musicId})
      await axios  //music_videos更新用
        .get(`/api/v1/music_videos/${this.$route.params.id}.json`)
        .then(response => (this.musicVideos = response.data))
      await axios
        .get(`/api/v1/videos/${this.$route.params.id}.json`)
        .then(response => (this.video.musics = response.data.musics))
    },
    async destroyVideoMusic(VideoMusic_id) {
      const videoMusicId = this.findVideoMusicId(VideoMusic_id);
      await axios
        .delete(`/api/v1/music_videos/${videoMusicId}`);
      await axios  //music_videos更新用
        .get(`/api/v1/music_videos/${this.$route.params.id}.json`)
        .then(response => (this.musicVideos = response.data))
      await axios
        .get(`/api/v1/videos/${this.$route.params.id}.json`)
        .then(response => (this.video.musics = response.data.musics))
    },
    findVideoMusicId(musicid) {
      const music = this.musicVideos.find((music) => {
        return (music.music_id === musicid)
      })
      if (music) { return music.id }
    },

    fetchAllVideos: async function () {
      await axios
      .get(`/api/v1/videos/all.json`)
      .then(response => (this.videos = response.data))
    },

    async createRelationship(id) {
      await axios.post(`/api/v1/relationships`,{video_id: this.video.id , recommend_id: id})
      this.fetchVideos(this.video.id);
    },
    destroyRelationship(id) {
      const relationship = this.findRelationshipId(id);
       axios.delete(`/api/v1/relationships/${relationship}`);
      this.fetchVideos(this.video.id);
    },
    findRelationshipId(id) {
      const relationship = this.relationships.find((relationship) => {
        return (relationship.recommend_id === id & relationship.video_id === this.video.id)
      })
      if (relationship) { return relationship.id }
    },

    fetchMusics: async function () {
      await axios
      .get(`/api/v1/musics/all.json`)
      .then(response => (this.musics = response.data))
    },

  }  //methods
}
</script>

<style lang="scss" scoped>

//  タブ  https://qiita.com/terufumi1122/items/16e7612a80f81f652000
.tabs {
  margin: 10px auto;
  padding: 10px;
  width: 100%;
  background: white;
  border-radius: 10px;
  .btn-container {
    margin-bottom: 10px;
    display: flex;
    justify-content: center;
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
  }
  .tab-content div {
    background: #ffffff;
    width: 100%;
    margin: 0 auto;
  }
}

textarea {
  width: 100%;
  height: 250px;
}

.minutes-to-second { //分数を秒数に変換するツール
  font-size: 40px;
  input[type="number"] {
    height: 50px;
    font-size: 30px;
  }
}

.comment-submit{
  display: flex;
  flex-direction: row-reverse;
}

.video-people, .penalties, .tags, .musics {
  display: flex;
  flex-wrap: wrap;
}

.person, .penalty, .tag, .place, .music {
  margin: 0 3px 3px 0;
}

.description-real {
  white-space: pre-line;  //本家の概要に改行を許可する
}

.text_line {
  margin-top: 30px;
  width: 100%;
  border-bottom: 2px solid rgb(0, 0, 0);
}

@media screen and (min-width: 1000px){
  .video_box{
    width : 60%;
  }
  .related-videos {
    width : 40%;
    margin-left: 20px;
    .update-video {
      margin-bottom: 80px;
      textarea {
        width: 100%;
        height: 600px;
      }
    }
    .tag-form {
      margin-top: 100px;
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

.red {
  background-color: red;
  color: white;
  -webkit-transform: translate(0);
  transform: translate(0) ;
  -webkit-transition: .3s ease-in-out;
  transition: .3s ease-in-out;
}
.red:hover {
  -webkit-transform: translateY(-5px) scale(1);
  transform: translateY(-5px) scale(1);
  opacity: 0.9;
}
.red-black {
  background-color: rgb(177, 0, 0);
  color: rgb(196, 196, 196);
}



</style>