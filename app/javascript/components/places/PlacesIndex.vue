<template>
  <div class="width-96">
    <p id="notice">{{ notice }}</p>

    <div v-for="place in places" :key="place.name" class="hashtags">
        <div class="btn btn-danger">
        <a :href="place.show">{{place.name }} ({{place.count}})</a>
        </div>
    </div>

  </div>
</template>

<script>
export default {
  name: 'PlacesIndex',
  props: {
    notice: {
      type: String,
      required: true
    },
    places: {
      type: Array,
      required: true
    }
  }
}
</script>

<style scoped>
</style>