<template>

<div>

  <div class="title">
    <h3> <router-link :to="{ name: 'PenaltiesIndex' }"> Penalties </router-link> / {{ penalty.name }} </h3>
  </div>

  <div class="person_background-image">
    <PeopleImages :person="penalty.person_id"></PeopleImages>      
  </div>

  <div class="person_introduce_box">
    <div class="person_image">
      <PeopleImages :person="penalty.person_id"></PeopleImages>      
    </div>

    <div class="person_name_description">
      <div class="person_name">
        <h3>{{ penalty.name }}</h3>
      </div>
      <div class="person_description">
        <p> since {{ penalty.since }} </p>  
        <p> {{ penalty.description }} </p>  
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


    <h2> {{ penalty.name }} が行われている動画リスト </h2>
      <VideosArticles :videos="penalty.videos"></VideosArticles>


  </div>

</div>

</template>

<script>
import axios from 'axios';

import PenaltyColor from '../PenaltyColor.vue';
import PeopleImages from '../people/PeopleImages.vue';
import VideosArticles from '../videos/VideosArticles.vue';


export default {
  components: {
    PenaltyColor,
    PeopleImages,
    VideosArticles
  },

  data: function () {
    return {
      penalty: {}
    }
  },
  mounted () {
      axios
      .get(`/api/v1/penalties/${this.$route.params.id}.json`)
      .then(response => (this.penalty = response.data))
  },

}  //export default
</script>

<style lang="scss" scoped>

</style>