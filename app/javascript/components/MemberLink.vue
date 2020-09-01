<template>

  <router-link :to="{ name: 'PeopleShow', params: { id: person } }" >
    <h3 v-if="     person == 1" class="btn tetsuya"    >てつや</h3>
    <h3 v-else-if="person == 2" class="btn shibayu"    >しばゆー</h3>
    <h3 v-else-if="person == 3" class="btn ryo"        >りょう</h3>
    <h3 v-else-if="person == 4" class="btn toshimitsu" >としみつ</h3>
    <h3 v-else-if="person == 5" class="btn yumemaru"   >ゆめまる</h3>
    <h3 v-else-if="person == 6" class="btn mushimegane">虫眼鏡</h3>
    <h3 v-else class="btn"> 選択していません</h3>  
  </router-link>

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