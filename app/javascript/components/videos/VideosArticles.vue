<template>
  <div id="app">
    <div class="video_articles">
      <div class="video_article" v-for="video in videos" :key="video.id">
        <router-link :to="{ name: 'VideosShow', params: { id: video.id } }">
          
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
            <div id="like-<%= video.id %>">

            </div>
          </div>

        </router-link>
      

      </div>
    </div>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  
  props: [
   'videos'
  ]

}

</script>

<style lang="scss" scoped>

@media screen and (min-width: 1000px){ //widthが900pxまでのCSS
  div[class*="video_articles"] {
    width: 100%;
    display: flex;
    flex-direction: row;
    flex-wrap: wrap;
    justify-content: center;
    a{
      font-size: 30px;
    }
  }

  .video_article {
    margin-right: 0.5em;
    margin-bottom: 1em;
    width :24%;
    border: 2px solid rgb(238, 237, 237)
  }
  .video_article-show {
    width: 400px;
    border: 2px solid rgb(238, 237, 237)

  }

  // ↓記事が上にホバーするコード
  .video_article{
    -webkit-transform: translate(0);
    transform: translate(0) ;
    -webkit-transition: .3s ease-in-out;
    transition: .4s ease-in-out;
  }
  .video_article:hover {
    -webkit-transform: translateY(-10px) scale(1);
    transform: translateY(-10px) scale(1);
    opacity: 0.5;
  }
  // ↑記事が上にホバーするコード

  .article-image {// iframeのheightをレスポンシブにする　https://akros-ac.jp/8277/
    position: relative;
    width: 100%;
    height: 0;
    padding-top: 56%;

    iframe ,img{
      position: absolute;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
    }
  }


  .article-column{
    display: flex;
    justify-content: space-between;
    flex-direction: column;
    
  }

  .article-title {
    width : 100%;
    font-size :16px
  }

  .article_title{
    overflow: hidden;
    height: 3em;
    line-height: 1.7;
  }

  .article_row{
    height: 52px;
    display: flex;
    align-items: center;
    justify-content: space-between;
  }

  .article-rate {
    width: 17%;
    display: flex;
    justify-content: center;
  }
  .S {
    color: gold;
  }
  .A {
    color: rgb(224, 12, 231);
  }
  .B {
    color: rgb(235, 29, 29);
  }
  .C {
    color: rgb(245, 158, 27);
  }

  .article-mvp {
    width: 25%;
    display: flex;
    justify-content: center;
    color:white;

    h3{
      white-space: nowrap;
      border-radius: 5px;
      padding: 1px 13px ;
      font-size: 16px;
    }
  }


  .article-tags{// ハッシュタグのデザイン
    width: 55%;
    height: 100%;
    display: flex;
    flex-wrap: wrap;

    .article-tag {
      width: 49%;
      height: 24px;
      margin: 0.5%;
      border-radius: 5px;
      background-color: rgb(0, 247, 255);
      display: flex;
      justify-content: center;
      align-items: center;

      h3 {
        font-size: 13px;
        color: white;
        white-space: nowrap;
        overflow: hidden;
        text-overflow: ellipsis;

      }
    }
  }

  .article-date {
    display: inline;
    font-size :13px;
    a {
      font-size: 13px !important;
    }
  }
  div[id*="like-"]{ //inlineがないと横並びにならない
    display: inline;
    margin-left: 10px;
  }
}
//ここまでvideo記事のデザイン

</style>