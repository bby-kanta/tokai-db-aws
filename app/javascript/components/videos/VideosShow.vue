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

    </div>

    <!-- <div id="like-<%= @video.id %>"> <%#いいね機能%>
      <%= render partial: "videos/like", locals: {video: @video }%>
    </div> -->

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
          <div class="highlight-content"> {{ video.highlight }} </div>
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

      <!-- <tr>
        <th> カテゴリー </th>
        <th>   
          <div class="btn video-category">
            <% case @video.category %>
              <% when 0 %>
                <%= link_to "企画もの", search_videos_path(@search, :'q[category_eq' => 0 ) %>
              <% when 1 %>
                <%= link_to "サブチャン", search_videos_path(@search, :'q[category_eq' => 1 ) %>
              <% when 2 %>
                <%= link_to "コント", search_videos_path(@search, :'q[category_eq' => 2 ) %>
              <% when 3 %>
                <%= link_to "クイズ", search_videos_path(@search, :'q[category_eq' => 3 ) %>
              <% when 4 %>
                <%= link_to "選手権", search_videos_path(@search, :'q[category_eq' => 4 ) %>
              <% when 5 %>
                <%= link_to "検証系", search_videos_path(@search, :'q[category_eq' => 5 ) %>
              <% when 6 %>
                <%= link_to "対決", search_videos_path(@search, :'q[category_eq' => 6 ) %>
              <% when 7 %>
                <%= link_to "王", search_videos_path(@search, :'q[category_eq' => 7 ) %>
              <% when 8 %>
                <%= link_to "文理対決", search_videos_path(@search, :'q[category_eq' => 8 ) %>
              <% when 9 %>
                <%= link_to "旅行", search_videos_path(@search, :'q[category_eq' => 9 ) %>
              <% when 10 %>
                <%= link_to "料理", search_videos_path(@search, :'q[category_eq' => 10 ) %>
              <% when 11 %>
                <%= link_to "スポーツ", search_videos_path(@search, :'q[category_eq' => 11 ) %>
              <% when 12 %>
                <%= link_to "ドッキリ", search_videos_path(@search, :'q[category_eq' => 12 ) %>
              <% when 13 %>
                <%= link_to "ゲーム", search_videos_path(@search, :'q[category_eq' => 13 ) %>
              <% when 14 %>
                <%= link_to "コラボ", search_videos_path(@search, :'q[category_eq' => 14 ) %>
              <% when 91 %>
                <%= link_to "ニンマリシティへようこそ", search_videos_path(@search, :'q[category_eq' => 91 ) %>
              <% when 92 %>
                <%= link_to "ゆめまる美術館", search_videos_path(@search, :'q[category_eq' => 92 ) %>
              <% when 93 %>
                <%= link_to "ブラーボりょうのボンサバドゥチャンネル", search_videos_path(@search, :'q[category_eq' => 93 ) %>
              <% when 94 %>
                <%= link_to "虫眼鏡の放送部", search_videos_path(@search, :'q[category_eq' => 94 ) %>
              <% when 95 %>
                <%= link_to "としみつ東海オンエアの", search_videos_path(@search, :'q[category_eq' => 95 ) %>
              <% when 96 %>
                <%= link_to "動画アップロードチャンネル", search_videos_path(@search, :'q[category_eq' => 96 ) %>
              <% when 99 %>
                <%= link_to "ごはんじゃんけん", search_videos_path(@search, :'q[category_eq' => 99 ) %>
              <% when 98 %>
                <%= link_to "いじわる", search_videos_path(@search, :'q[category_eq' => 98 ) %>
              <% when 97 %>
                <%= link_to "十字架(サブチャン)", search_videos_path(@search, :'q[category_eq' => 97 ) %>
              <% else %>
                <%= link_to "その他", search_videos_path(@search, :'q[kind_of_eq' => 3 ) %>
            <% end %>
          </div>
        </th>
      </tr> -->

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
    <VideosRecommend :videos="videos"></VideosRecommend>
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
      videos: {}
    }
  },

  // mounted () {
  //   axios
  //     .get(`/api/v1/videos/${this.$route.params.id}.json`)
  //     .then(response => (this.video = response.data))
  // },

  watch: {
    $route (to, from) {
      // this.$router.go({ name: 'VideosShow' })
      this.fetchVideos(to.params.id)
      }
  },
    methods: {
    fetchVideos(id) {
      axios
      .get(`/api/v1/videos/${this.$route.params.id}.json`)
      .then(response => (this.video = response.data))
      
      axios
      .get('/api/v1/videos/recommend.json')
      .then(response => (this.videos = response.data))

    }
  }
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


</style>