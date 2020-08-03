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


    <!-- <div class="recommend-penalty">
      <h2>おすすめ罰ゲーム</h2>
      <div class="penalties">
        <%= render partial: "penalty-color", locals: { penalties: @penalties }%>
      </div>
    </div> -->

    <h2 class="width-96"> おすすめタグ </h2>
      <div class="hash-tags gray">
        <div class="hash-tag" v-for="tag in random(tags, 20)" :key="tag.id">
          <TagColor :person="tag.person_id" :tag_id="tag.id" :tag_name="tag.name" :count="'('+ tag.videos.length +')' "></TagColor>
        </div>
      </div>

  <div class="width-96">
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

  created() {
    this.fetchTag(this.$route.params.id)
  },

  data: function () {
    return {
      tag: {},
      tags: {}
    }
  },
  mounted () {
      axios
      .get('/api/v1/tags.json')
      .then(response => (this.tags = response.data))
  },

  watch: {
    $route (to, from) {
      this.fetchTag(to.params.id)
      }
  },

  methods: {
    fetchTag(id) {
      axios
      .get(`/api/v1/tags/${this.$route.params.id}.json`)
      .then(response => (this.tag = response.data))
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
    }
  }

}  //export default
</script>

<style lang="scss" scoped>

.hash-tags {
  display: flex;
  margin: 10px 0 30px 0;
  flex-wrap: wrap;
  .hash-tag {
    margin: 0 10px 10px 0;
  }
}

</style>