<template>
  <div id="app">
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

</style>