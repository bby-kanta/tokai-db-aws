<template>

<div class="show-person_page">
  <div class="title">
    <h3> <router-link :to="{ name: 'PeopleIndex' }"> Character </router-link> / {{ person.name }} </h3>
  </div>

  <div class="person_background-image">
    <PeopleImages :person="person.id"></PeopleImages>      
  </div>

  <div class="person_introduce_box">
    <div class="person_image">
      <PeopleImages :person="person.id"></PeopleImages>      
    </div>

    <div class="person_name_description">
      <div class="person_name">
        <h3> {{ person.name }} </h3>
      </div>
      <div class="person_description">
        <p> {{ person.description }} </p>
      </div>
    </div>
  </div>

  <h3 class="width-96"> {{ person.name }} に関係するハッシュタグ </h3>
  <div class="person_tags">
    <div class="person-tag" v-for="tag in person.tags" :key="tag.id">
      <TagColor :person="person.id" :tag_id="tag.id" :tag_name="tag.name" ></TagColor>
    </div>
  </div>

  <h3 class="width-96"> {{ person.name }} に関係する罰ゲーム </h3>
  <div class="person_penalties">
    <div class="person-penalty" v-for="penalty in person.penalties" :key="penalty.id">
      <PenaltyColor :person="person.id" :penalty_id="penalty.id" :penalty_name="penalty.name"></PenaltyColor>
    </div>
  </div>

  <div class="Appear-on-videos">
    <h2> {{ person.name }} さんが出演している動画（ランダムで表示されます） </h2>
  </div>

  <div class="video_articles">
    <VideosArticles :videos="person.videos"></VideosArticles>
  </div>

</div>

</template>

<script>
import axios from 'axios';

import PeopleImages from './PeopleImages.vue';
import TagColor  from '../TagColor.vue';
import PenaltyColor  from '../PenaltyColor.vue';
import VideosArticles from '../videos/VideosArticles.vue';


export default {
  components: {
    PeopleImages,
    TagColor,
    PenaltyColor,
    VideosArticles
  },

  data: function () {
    return {
      person: {}
    }
  },
  mounted () {
      axios
      .get(`/api/v1/people/${this.$route.params.id}.json`)
      .then(response => (this.person = response.data))
  },

}  //export default
</script>

<style lang="scss" scoped>

  .person_tags {
    display: flex;
  }

  h2 {
    margin-bottom: 1%;
  }

  .person_background-image {
    img {
      width: 100%;
      height: 300px;
      position: absolute;
      object-fit: cover;  //トリミング
      object-position: 0 30%;
      opacity: 0.4;
      filter: blur(5px);
    }
  }

  .person_tags , .person_penalties {
    padding: 30px 0px;
    background-color: rgb(250, 250, 250);

    .person-tag , .person-penalty {
      margin-left: 4%;
    }
  }

  .btn a{
    color: white;
  }

  .Appear-on-videos {
    margin: 20px 0px;
    display: flex;
    justify-content: center
  }



  @media screen and (max-width: 999px){ //widthが999pxまでのCSS(スマホ用)

  }

</style>