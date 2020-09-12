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

  <div class="person-tags-title">
    <h3> {{ person.name }} に関係するハッシュタグ </h3>
    <p v-if="user != 'none'" @click="openModal" class="orange">{{person.name}}のタグを作る</p> <!-- モーダルウインドウのボタン https://reffect.co.jp/vue/understand-component-by-moda-window -->
  </div>
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

  <div id="overlay" v-show="showContent"> <!-- モーダルウインドウの中身 -->
    <div id="modal-content">
      <i class="fas fa-times fa-2x" @click="closeModal"></i>
      <h2>{{person.name}}のタグを作る</h2>

      <div class="comment-form">
        <input v-model="tag.name" class="comment-box" type="text" placeholder="タグ名を入力する">
        <input v-model="tag.sort" class="comment-box" type="text" placeholder="ふりがなを入力する">
        <textarea v-model="tag.description" class="" placeholder="概要を入力する"></textarea>
      </div>

      <div class="comment-submit">
        <button @click="createTag()">作成</button>
      </div>

    </div>
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
    createTag: async function() {
      await axios
        .post('/api/v1/tags',{ name: this.tag.name , sort: this.tag.sort, description: this.tag.description ,person_id: this.person.id} );
      await axios
      .get(`/api/v1/people/${this.$route.params.id}.json`)
      .then(response => (this.person = response.data))
      this.closeModal()
      this.tag.name = ""
      this.tag.sort = ""
      this.tag.description = ""
    },
  }

}  //export default
</script>

<style lang="scss" scoped>

  .person-tags-title {
    width: 96%;
    margin: 0 auto;
    display: flex;
    align-items: center;
    p {
      margin-left: 20px;
      cursor: pointer;
    }
  }
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
      border-radius: 20px;
      i {
        color: orange;
        cursor: pointer;
      }
      form {
        .comment-form {
          display: flex;
          flex-direction: column;
          input {
            margin : 5px 0;
          }
          textarea {
            width: 100%;
            height: 100px;
            margin : 5px 0;
          }
        }
        .comment-submit {
          display: flex;
          flex-direction: row-reverse;
        }
      }
    }
  }


  @media screen and (max-width: 999px){ //widthが999pxまでのCSS(スマホ用)

  }

</style>