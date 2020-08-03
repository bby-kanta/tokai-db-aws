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

        <div class="places">
            <div class="place btn btn-danger" v-for="place in places" :key="place.id">
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
      places: []
    }
  },
  mounted () {
    axios
      .get('/api/v1/places.json')
      .then(response => (this.places = response.data))
  },

}  //export default
</script>

<style lang="scss" scoped>

</style>