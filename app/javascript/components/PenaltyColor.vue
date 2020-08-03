<template>

  <router-link :to="{ name: 'PenaltiesShow', params: { id: penalty_id } }" >
    <h3 v-if="     person == 1" class="btn tetsuya"    > {{ penalty_name }} {{count}} </h3>
    <h3 v-else-if="person == 2" class="btn shibayu"    > {{ penalty_name }} {{count}} </h3>
    <h3 v-else-if="person == 3" class="btn ryo"        > {{ penalty_name }} {{count}} </h3>
    <h3 v-else-if="person == 4" class="btn toshimitsu" > {{ penalty_name }} {{count}} </h3>
    <h3 v-else-if="person == 5" class="btn yumemaru"   > {{ penalty_name }} {{count}} </h3>
    <h3 v-else-if="person == 6" class="btn mushimegane"> {{ penalty_name }} {{count}} </h3>
    <h3 v-else class="btn tokai"> {{ penalty_name }} {{count}} </h3>  
  </router-link>

</template>

<script>

export default {

  props: [
    'person',
    'penalty_id',
    'penalty_name',
    'count'
  ]
  
}  //export default
</script>

<style lang="scss" scoped>

</style>