<template>

  <router-link :to="{ name: 'TagsShow', params: { id: tag_id } }" >
    <h3 v-if="     person == 1" class="btn tetsuya"    > {{ tag_name }} {{count}} </h3>
    <h3 v-else-if="person == 2" class="btn shibayu"    > {{ tag_name }} {{count}} </h3>
    <h3 v-else-if="person == 3" class="btn ryo"        > {{ tag_name }} {{count}} </h3>
    <h3 v-else-if="person == 4" class="btn toshimitsu" > {{ tag_name }} {{count}} </h3>
    <h3 v-else-if="person == 5" class="btn yumemaru"   > {{ tag_name }} {{count}} </h3>
    <h3 v-else-if="person == 6" class="btn mushimegane"> {{ tag_name }} {{count}} </h3>
    <h3 v-else class="btn tokai"> {{ tag_name }} {{count}} </h3>  
  </router-link>

</template>

<script>

export default {

  props: [
    'person',
    'tag_id',
    'tag_name',
    'count'
  ]
  
}  //export default
</script>

<style lang="scss" scoped>

</style>