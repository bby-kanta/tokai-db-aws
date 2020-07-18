<template>

<div class="place-show">
  <table class="table table-borderless">
    <tr> 
      <th>撮影場所名</th> 
      <th> {{ name }} </th> 
    </tr>
    <tr> 
      <th>概要</th> 
      <th> {{ description }} </th>
    </tr>
  </table>
</div>

</template>

<script>
export default {
  name: 'PlacesShow',
  props: {
    name: {
      type: String,
      required: true
    },
    description: {
      type: String,
      required: true
    },
    editPlacePath: {
      type: String,
      required: true
    }
  }
}
</script>

<style scoped>
</style>