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

      <input type="text" v-model="keyword" placeholder="BGM検索">

      <div class="musics">
          <div class="btn btn-success music" v-for="music in filteredMusics" :key="music.id">
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
      musics: [],
      keyword: '',
    }
  },
  mounted () {
    axios
      .get('/api/v1/musics.json')
      .then(response => (this.musics = response.data))
  },

  computed: {
    filteredMusics: function() { //検索機能

      var musics = [];

      for(var i in this.musics) {
        var music = this.musics[i];
        if(music.name.indexOf(this.keyword) !== -1) {
          musics.push(music);
        }
      }
      return musics;
    },

  }

}  //export default
</script>

<style lang="scss" scoped>

input {
  width: 20%;
  margin-top: 20px;
}

.musics {
  margin-top: 30px;
  display : flex;
  flex-wrap: wrap;
  .music {
    margin: 0 10px 10px 0;
  }
}

</style>