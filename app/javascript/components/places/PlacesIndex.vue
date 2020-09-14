<template>
  <div>

    <div class="background-image">
      <img src="../../../assets/images/okazaki.jpeg">
    </div>

    <div class="background-title">
      <div class="background-title-column">
        <h3>PLACES</h3>
        <h2>撮影場所</h2>
      </div>
    </div>

    <div class="width-96">

        <input type="text" v-model="keyword" placeholder="撮影場所検索">

        <div class="places">
            <div class="place btn btn-danger" v-for="place in filteredPlaces" :key="place.id">
              <router-link :to="{ name: 'PlacesShow', params: { id: place.id } }" >
                {{ place.name }} {{ '(' + place.videos.length + ')' }}
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
      places: [],
      keyword: '',
    }
  },
  mounted () {
    axios
      .get('/api/v1/places.json')
      .then(response => (this.places = response.data))
  },

  computed: {
    filteredPlaces: function() { //検索機能

      var places = [];

      for(var i in this.places) {
        var place = this.places[i];
        if(place.name.indexOf(this.keyword) !== -1 ) {
          places.push(place);
        }
      }
      return places;
    },

  }

}  //export default
</script>

<style lang="scss" scoped>

input {
  width: 20%;
  margin-top: 20px;
}

.places {
  margin-top: 30px;
  display : flex;
  flex-wrap: wrap;
  .place {
    margin: 0 10px 10px 0;
  }
}

</style>