<template>
  <div id="app">
    <div class="title">
      <h3>{{ user.name }}さんがいいねした動画一覧</h3>
    </div>
    <VideosArticles :videos="videos"></VideosArticles>
    <infinite-loading @infinite="infiniteHandler"></infinite-loading>
  </div>
</template>

<script>
import axios from 'axios';
import VideosArticles from '../videos/VideosArticles.vue';
import SubscriberCounter from '../SubscriberCounter.vue';

export default {
  components: {
    VideosArticles,
    SubscriberCounter,
  },

  data: function () {
    return {
      user: '',
      videos: [],
      page: 1,
    }
  },

  mounted () {
    axios
      .get(`/api/v1/users/${this.$route.params.id}`)
      .then(response => (this.user = response.data.user)) 
  },

  computed: {

  },  //computed

  methods: {
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
    }
  }

}  //export default
</script>

<style lang="scss" scoped>
.title {
  margin-bottom: 20px;
}
</style>