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

  <div class="dip-fl mb-5">
    <button v-if="user == tag.user_id" @click="openModal">編集</button> <!-- モーダルウインドウのボタン https://reffect.co.jp/vue/understand-component-by-moda-window -->
    <button v-if="user == tag.user_id" @click="confirmDelete(), destroyTag(tag.id)">削除</button>
  </div>

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

  <div id="overlay" v-show="showContent"> <!-- モーダルウインドウの中身 -->
    <div id="modal-content">
      <i class="fas fa-times fa-2x" @click="closeModal"></i>
      <h2>{{tag.name}}を編集する</h2>
      <form @submit="UpdateTag">

        <div class="comment-form">
          <input v-model="tag.name" class="comment-box" type="text" placeholder="タグ名を入力する">
          <input v-model="tag.sort" class="comment-box" type="text" placeholder="ふりがなを入力する">
          <textarea v-model="tag.description" class="" placeholder="概要を入力する"></textarea>
        </div>

        <div class="comment-submit">
          <button type="submit">作成</button>
        </div>

      </form>
    </div>
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
      user:'',
      showContent: false,
      tag: {},
      tags: {},

    }
  },
  mounted () {
      axios
      .get('/api/v1/tags.json')
      .then(response => (this.tags = response.data))
      axios
      .get('/api/v1/users.json')
      .then(response => (this.user = response.data))
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
    },
    openModal: function(){
      this.showContent = true
    },
    closeModal: function(){
      this.showContent = false
    },
    UpdateTag: function() {
      axios
        .put(`/api/v1/tags/${this.tag.id}`,{ name: this.tag.name , sort: this.tag.sort, description: this.tag.description} );
      this.$router.go({path: this.$router.currentRoute.path, force: true})
    },
    destroyTag(tag_id) {
      const tag = tag_id
      console.log('コメントID'+tag+'を消します')
      axios.delete(`/api/v1/tags/${tag}`);
      this.$router.push({ name: 'TagsIndex'})
    },
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