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

  <button v-if="user != 'none'" @click="openModal">{{person.name}}のタグを作る</button> <!-- モーダルウインドウのボタン https://reffect.co.jp/vue/understand-component-by-moda-window -->
  <div id="overlay" v-show="showContent"> <!-- モーダルウインドウの中身 -->
    <div id="modal-content">
      <p>これがモーダルウィンドウです。</p>
      <form @submit="createTag">

        <div class="comment-form">
          <input v-model="tag.name" class="comment-box" type="text" placeholder="タグ名を入力する">
          <input v-model="tag.sort" class="comment-box" type="text" placeholder="ふりがなを入力する">
          <input v-model="tag.description" class="comment-box" type="text" placeholder="概要を入力する">
        </div>

        <div class="comment-submit">
          <button type="submit"> コメント </button>
        </div>

      </form>
      <p><button @click="closeModal">close</button></p>
    </div>
  </div>

  <h3 class="width-96"> {{ person.name }} に関係するハッシュタグ </h3>
  <div class="person_tags ">
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
      user: '',
      person: {},
      showContent: false,

      tag: {
        name: "",
        sort: "",
        description: "",
      },
     }
  },
  mounted () {
      axios
      .get(`/api/v1/people/${this.$route.params.id}.json`)
      .then(response => (this.person = response.data))
      axios
      .get('/api/v1/users.json')
      .then(response => (this.user = response.data))
  },
  methods: {
    openModal: function(){
      this.showContent = true
    },
    closeModal: function(){
      this.showContent = false
    },
    createTag: function() {
      axios
        .post('/api/v1/tags',{ name: this.tag.name , sort: this.tag.sort, description: this.tag.description ,person_id: this.person.id} );
      // this.fetchVideos(this.video.id);
      this.$router.go({path: this.$router.currentRoute.path, force: true})
    },
  }

}  //export default
</script>

<style lang="scss" scoped>

  .person_tags , .person_penalties {
    display: flex;
    flex-wrap: wrap;
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
    padding: 30px 30px;
    background-color: rgb(250, 250, 250);

    .person-tag , .person-penalty {
      margin: 0 10px 10px 0;
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
  
  #overlay{ //モーダルウインドウ
    /*　要素を重ねた時の順番　*/
    z-index:1;
    /*　画面全体を覆う設定　*/
    position:fixed;
    top:0;
    left:0;
    width:100%;
    height:100%;
    background-color:rgba(0,0,0,0.5);
    /*　画面の中央に要素を表示させる設定　*/
    display: flex;
    align-items: center;
    justify-content: center;
    #modal-content { //モーダルウインドウの中身
      z-index:2;
      width:50%;
      padding: 1em;
      background:#fff;
    }
  }


  @media screen and (max-width: 999px){ //widthが999pxまでのCSS(スマホ用)

  }

</style>