<template>

<div>
  <div class="background-image">
    <img src="../../../assets/images/tokai-onair4.jpg">
  </div>
  <div class="background-title">
    <div class="background-title-column">
      <h3>Hashtags</h3>
      <h2>ハッシュタグ</h2>
    </div>
  </div>

  <div class="width-96">
    <div class="hash-tags">
      <div class="hash-tag" v-for="tag in tags" :key="tag.id">
        <TagColor :person="tag.person_id" :tag_id="tag.id" :tag_name="tag.name" :count="'('+ tag.videos.length +')' "></TagColor>
      </div>
    </div>
  </div>

</div>

</template>

<script>
import axios from 'axios';

import TagColor from '../TagColor.vue';

export default {
  components: {
    TagColor
  },

  data: function () {
    return {
      tags: []
    }
  },
  mounted () {
    axios
      .get('/api/v1/tags.json')
      .then(response => (this.tags = response.data))
  },

}  //export default
</script>

<style lang="scss" scoped>

  .hash-tags {
    display : flex;
  }

</style>