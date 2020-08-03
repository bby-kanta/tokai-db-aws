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


  <h2 class="width-96"> おすすめ罰ゲームor十字架 </h2>
    <div class="penalties gray">
      <div class="penalty" v-for="penalty in random(penalties,20)" :key="penalty.id">
        <PenaltyColor :person="penalty.person_id" :penalty_id="penalty.id" :penalty_name="penalty.name" :count=" '(' + penalty.videos.length + ')' "></PenaltyColor>
      </div>
    </div>

  <div class="width-96">

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

  created() {
    this.fetchPenalty(this.$route.params.id)
  },

  data: function () {
    return {
      penalty: {},
      penalties: {}
    }
  },
  mounted () {
    axios
    .get('/api/v1/penalties.json')
    .then(response => (this.penalties = response.data))

    axios
    .get(`/api/v1/penalties/${this.$route.params.id}.json`)
    .then(response => (this.penalty = response.data))
  },
  
  watch: {
    $route (to, from) {
      this.fetchPenalty(to.params.id)
    }
  },

  methods: {
    fetchPenalty(id) {
      axios
      .get(`/api/v1/penalties/${this.$route.params.id}.json`)
      .then(response => (this.penalty = response.data))
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
    }//random
  }//methods

}  //export default
</script>

<style lang="scss" scoped>

  .penalties {
    margin: 20px 0;
    display: flex;
    flex-wrap: wrap;
    .penalty {
      margin: 0 10px 10px 0;
    }
  }

</style>