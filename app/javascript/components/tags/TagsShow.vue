<template>

<div>

  <div class="title">
    <h3> <router-link :to="{ name: 'TagsIndex' }"> Tags </router-link> / {{ tag.name }} </h3>
  </div>

  <div class="person_background-image">
    <PeopleImages :person="tag.person_id"></PeopleImages>
  </div>

  <div class="person_introduce_box">
    <div class="person_image">
      <PeopleImages :person="tag.person_id"></PeopleImages>
    </div>

    <div class="person_name_description">
      <div class="person_name">
        <h3>{{ tag.name }}</h3>
      </div>
      <div class="person_description">
        <p> {{ tag.description }} </p>  
      </div>
    </div>
  </div>

  <div class="width-96">
    <!-- <div class="recommend-penalty">
      <h2>おすすめ罰ゲーム</h2>
      <div class="penalties">
        <%= render partial: "penalty-color", locals: { penalties: @penalties }%>
      </div>
    </div> -->


    <h2> {{ tag.name }} が行われている動画リスト </h2>
      <VideosArticles :videos="tag.videos"></VideosArticles>


  </div>

</div>

</template>

<script>
import axios from 'axios';

import TagColor from '../TagColor.vue';
import PeopleImages from '../people/PeopleImages.vue';
import VideosArticles from '../videos/VideosArticles.vue';


export default {
  components: {
    TagColor,
    PeopleImages,
    VideosArticles
  },

  data: function () {
    return {
      tag: {}
    }
  },
  mounted () {
      axios
      .get(`/api/v1/tags/${this.$route.params.id}.json`)
      .then(response => (this.tag = response.data))
  },

}  //export default
</script>

<style lang="scss" scoped>

</style>