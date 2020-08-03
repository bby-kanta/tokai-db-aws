<template>
  <img v-if="person == 1" src="../../../assets/images/tetsuya.jpg">
  <img v-else-if="person == 2" src="../../../assets/images/sibayu.jpg">
  <img v-else-if="person == 3" src="../../../assets/images/ryo.jpg">
  <img v-else-if="person == 4" src="../../../assets/images/toshimitsu.jpg">
  <img v-else-if="person == 5" src="../../../assets/images/yumemaru.jpg">
  <img v-else-if="person == 6" src="../../../assets/images/mushimegane.jpg">
  <img v-else src="../../../assets/images/onair-bird.jpg">
</template>

<script>

export default {

  props: [
    'person'
  ]
  
}  //export default
</script>

<style lang="scss" scoped>

</style>