<template>
  <div id="app">
    <div class="title">
      <h3> マイページ / {{user.name}} </h3>
    </div>

    <div class="person_background-image">
      <PeopleImages :person='7'></PeopleImages>      
    </div>

    <div class="person_introduce_box">
      <div class="person_image">
        <PeopleImages :person="7"></PeopleImages>      
      </div>

      <div class="person_name_description">
        <div class="person_name">
          <h3> {{ user.name }} </h3>
          <p v-if="currentUser === user.id" @click="openModal" class="blue">編集</p>
        </div>
        <div class="person_description">
          <p>東海オンエアファン歴{{user.history}}年</p>
          <p>
            一番好きなメンバー：
            <MemberLink :person="user.person_id"></MemberLink>    
          </p>
          <p>{{user.description}}</p>
        </div>
      </div>
    </div>

    <div class="tabs">
      <div class="btn-container">
        <button v-for="(tab, index) in tabs"
                :key="tab.id"
                :class="{ active: currentTab === index }"
                @click="currentTab = index">{{ tab.tabName }}</button>
      </div>

      <div class="tab-content">
        <div v-show="currentTab === 0">
          <VideosArticles :videos="videos"></VideosArticles>
          <infinite-loading @infinite="infiniteHandler"></infinite-loading>
        </div>
        <div v-show="currentTab === 1">
          <div class="hash-tags">
            <div class="hash-tag" v-for="tag in tags" :key="tag.id">
              <TagColor :person="tag.person_id" :tag_id="tag.id" :tag_name="tag.name" :count="'('+ tag.tag_videos_count +')' "></TagColor>
            </div>
          </div>
        </div>
        <div v-show="currentTab === 2" class="comments-box">
            <div class="comments">
              <div v-for="comment in comments" :key="comment.id" class="comment">
                <router-link :to="{ name: 'VideosShow', params: { id: comment.video_id } }">
                  <div class="comment-video-title">
                    <i class="fas fa-arrow-left"></i>
                    {{comment.video.title}}
                  </div>
                  <div class="comment-name">
                    <img src="../../../assets/images/peace.jpg" width="30" height="30">
                    <h2>{{ user.name }}</h2>
                    <!-- <i v-if="comment.user.id == user " @click="confirmDelete(), destroyComment(comment.id)" class="far fa-trash-alt"></i> -->
                  </div>
                  <div class="comment-text">
                    <p> {{ comment.content }} </p>
                  </div>
                </router-link>
              </div>
            </div>
          <infinite-loading @infinite="infiniteHandlerComment"></infinite-loading>
        </div>
      </div>
    </div>

    <div id="overlay" v-show="showContent"> <!-- モーダルウインドウの中身 -->
      <div id="modal-content">
        <i class="fas fa-times fa-2x" @click="closeModal"></i>
        <form @submit="updateUser">

          <div class="comment-form">
            <div class="mt-2 mb-3">
              <p>ユーザー名</p>
              <input v-model="user.name" class="comment-box" type="text" placeholder="ユーザー名を入力する">
            </div>
            <div class="mb-3">
              <p>ファン歴</p>
              <input v-model="user.history" class="comment-box" type="number" placeholder="ファン歴を入力する">
            </div>
            <div class="mb-3">
              <p>一番好きなメンバー</p>
              <select v-model="user.person_id">
                <option value=''>一番好きなメンバー</option>
                <option value=1>てつや</option>
                <option value=2>しばゆー</option>
                <option value=3>りょう</option>
                <option value=4>としみつ</option>
                <option value=5>ゆめまる</option>
                <option value=6>虫眼鏡</option>
              </select>
            </div>
            <div class="mb-3">
              <p>自己紹介</p>
              <textarea v-model="user.description" class="" placeholder="自己紹介を入力する"></textarea>
            </div>
          </div>

          <div class="comment-submit">
            <button type="submit">更新</button>
          </div>

        </form>
      </div>
    </div>

  </div>
</template>

<script>
import axios from 'axios';
import VideosArticles from '../videos/VideosArticles.vue';
import SubscriberCounter from '../SubscriberCounter.vue';
import TagColor from '../TagColor.vue';
import PeopleImages from '../people/PeopleImages.vue';
import MemberLink from '../MemberLink.vue';

export default {
  components: {
    VideosArticles,
    SubscriberCounter,
    TagColor,
    PeopleImages,
    MemberLink,
  },

  data: function () {
    return {
      currentUser: '',
      user: '',
      videos: [],
      tags: [],
      comments: [],
      page: 2,
      comment_page: 2,
      //タブ
      currentTab: 0,
      id: 0,
      tabName: "",
      tabs: [
        {id: 1, tabName: 'いいね'},
        {id: 2, tabName: '作ったタグ'},
        {id: 3, tabName: 'コメント'},
      ],
    }
  },

  mounted () {
    axios
      .get(`/api/v1/users`)
      .then(response => (this.currentUser = response.data))
      
    this.fetchUser()
  },

  computed: {

  },  //computed

  methods: {
    fetchUser: async function () {
      await axios
        .get(`/api/v1/users/${this.$route.params.id}`)
        .then(response => (this.videos = response.data.videos ,this.comments = response.data.comments,this.user = response.data.user,this.tags = response.data.tags))
    },

    updateUser: function(){
      axios
        .put(`/api/v1/users/${this.user.id}`,{ name: this.user.name, description: this.user.description, history: this.user.history, person_id: this.user.person_id} )
        .then(response => {
          this.$router.push({ name: 'UsersShow', params: { id: this.user.id } });
        })
      this.fetchUser()
      this.closeModal()
    },

    infiniteHandler($state) {
        axios.get(`/api/v1/users/${this.$route.params.id}`, {
            params: {
                page: this.page,
            },
        }).then(({ data }) => {
            //そのままだと読み込み時にカクつくので1500毎に読み込む
            setTimeout(() => {
                if (this.page <=data.kaminari.pagenation.pages) {
                    this.page += 1
                    this.videos.push(...data.videos)
                    $state.loaded()
                } else {
                    $state.complete()
                }
            }, 800)
        }).catch((err) => {
            $state.complete()
        })
    },

    infiniteHandlerComment($state) {
        axios.get(`/api/v1/users/${this.$route.params.id}`, {
            params: {
                page: this.comment_page,
            },
        }).then(({ data }) => {
            //そのままだと読み込み時にカクつくので1500毎に読み込む
            setTimeout(() => {
                if (this.comment_page <= data.pagenation_comments.pagenation.pages) {
                    this.comment_page += 1
                    this.comments.push(...data.comments)
                    $state.loaded()
                } else {
                    $state.complete()
                }
            }, 800)
        }).catch((err) => {
            $state.complete()
        })
    },
  }

}  //export default
</script>

<style lang="scss" scoped>
.title {
  margin-bottom: 20px;
}

.hash-tags {
  margin-top: 30px;
  display : flex;
  flex-wrap: wrap;
  .hash-tag {
    margin: 0 10px 10px 0;
  }
}

.comments {
  width: 70%;
  margin: 20px auto;
  .comment:hover {
    border-bottom: 2px solid #ff8c00;
  }
  .comment {
    margin: 5px 0 0 0;
    padding-bottom: 10px;
    border-bottom: 2px solid #c2c2c2;
    .comment-video-title {
      margin: 0 0 10px 0;
      color: rgb(136, 136, 136);
    }
    .comment-name {
      margin-bottom: 10px;
      display:flex;
      align-items: center;
      h2 {
        margin: 0 10px;
      }
      img {
        border-radius: 50%;
        border: 1px solid rgb(53, 53, 53);
      }
      i:before, i:before {
        cursor: pointer;
      }
    }
    .comment-text {
      p {
        margin-left: 40px;
      }
    }
  }
}

//  タブ  https://qiita.com/terufumi1122/items/16e7612a80f81f652000
.tabs {
  margin: 10px auto;
  padding: 10px;
  width: 100%;
  background: white;
  border-radius: 10px;
  .btn-container {
    margin-bottom: 30px;
    display: flex;
    justify-content: center;
  }
  button {
    width: 30%;
    font-size: 20px;
    text-align: center;
    margin: 10px;
    padding: 3px 10px;
    background: white;
    border-radius: 10px;
    color: rgb(199, 199, 199);
    border: none;
  }
  button.active{
    background: rgb(255, 145, 0);
    color: white;
    border-color: white;
  }
}

</style>