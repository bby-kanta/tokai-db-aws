<template>

<div>

  <div class="title">
    <h3> <router-link :to="{ name: 'PlacesIndex' }"> Places </router-link> / {{ place.name }} </h3>
  </div>

  <div class="person_background-image">
    <PeopleImages :person='0'></PeopleImages>
  </div>

  <div class="person_introduce_box">
    <div class="person_image">
      <PeopleImages :person='0'></PeopleImages>
    </div>

    <div class="person_name_description">
      <div class="person_name">
        <h3>{{ place.name }}</h3>
      </div>
      <div class="person_description">
        <p> {{ place.description }} </p>  
      </div>
    </div>
  </div>

  <div class="width-96">

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

    <h2> {{ place.name }} で撮影された動画リスト </h2>
      <VideosArticles :videos="place.videos"></VideosArticles>

  </div>

</div>

</template>

<script>
import axios from 'axios';

import VideosArticles from '../videos/VideosArticles.vue';
import PeopleImages from '../people/PeopleImages.vue';


export default {
  components: {
    VideosArticles,
    PeopleImages
  },

  data: function () {
    return {
      place: {}
    }
  },
  mounted () {
      axios
      .get(`/api/v1/places/${this.$route.params.id}.json`)
      .then(response => (this.place = response.data))
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