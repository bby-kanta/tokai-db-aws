<template>
  <div>
    <div class="background-image">
      <img src="../../../assets/images/bgm.jpg">
    </div>
    <div class="background-title">
      <div class="background-title-column">
        <h3>BGM</h3>
        <h2>東海オンエア愛用音源</h2>
      </div>
    </div>

    <div class="width-96">

      <div class="musics">
          <div class="btn btn-success music" v-for="music in musics" :key="music.id">
              <router-link :to="{ name: 'MusicsShow', params: { id: music.id } }" >
                {{ music.name }} {{ '(' + music.videos.length + ')' }}
              </router-link>
          </div>
      </div>

    </div>
    
  </div>
</template>

<script>
import axios from 'axios';

export default {

  data: function () {
    return {
      musics: []
    }
  },
  mounted () {
    axios
      .get('/api/v1/musics.json')
      .then(response => (this.musics = response.data))
  },

}  //export default
</script>

<style lang="scss" scoped>

</style>