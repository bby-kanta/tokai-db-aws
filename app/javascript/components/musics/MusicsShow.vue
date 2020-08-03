<template>

<div>

  <div class="title">
    <h3> <router-link :to="{ name: 'MusicsIndex' }"> BGM </router-link> / {{ music.name }} </h3>
  </div>

  <div class="music-player-background">
    <div class="music-player">
      <iframe :src="'https://www.youtube.com/embed/'+ music.url+'?autoplay=1&loop=1&playlist='+ music.url" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
    </div>
  </div>

  <div class="width-96">
    <div class="music-show">
      <h1> {{ music.name }} </h1>
      <p> {{ music.description }} </p>
    </div>

    <!-- <div class="recommend-bgm">
      <h2>おすすめBGM</h2>
      <% @musics.each do |music|%>
        <div class="btn btn-success">
          <%= link_to music_path(music.id) do %>
            <%= music.name %>
            (<%= music.videos.count %>)
          <% end %>
        </div>
      <% end %>
    </div> -->

    <h2> {{ music.name }} が使われている動画リスト </h2>
      <VideosArticles :videos="music.videos"></VideosArticles>

  </div>

</div>

</template>

<script>
import axios from 'axios';

import VideosArticles from '../videos/VideosArticles.vue';


export default {
  components: {
    VideosArticles
  },

  data: function () {
    return {
      music: {}
    }
  },
  mounted () {
      axios
      .get(`/api/v1/musics/${this.$route.params.id}.json`)
      .then(response => (this.music = response.data))
  },

}  //export default
</script>

<style lang="scss" scoped>

.btn {
  border-radius: 5px;
  border-color: transparent;
  a , a:visited{
    color: white;
    font-size: unset;
  }
}

h2{
  margin-bottom: 20px;
}

.music-player-background {
  background-color: black;
  display: flex;
  align-items: center;
  justify-content: center;
  .music-player {
  position: relative;
  width: 70%;
  height: 0;
  padding-top: 30%;
  iframe {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
  }
  }
}

.music-show {
  margin :30px 0;
}

.recommend-bgm {
  margin : 30px 0;
}

@media screen and (max-width: 999px){ //widthが999pxまでのCSS(スマホ用)
  .music-player {
    width: 100%;
    padding-top: 56%;
  }

  .music-player-background {

    .music-player {
      width: 100%;
      padding-top: 56%;
    }
  }

}

</style>