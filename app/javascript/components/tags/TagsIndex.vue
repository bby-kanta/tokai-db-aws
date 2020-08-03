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
    <input type="text" v-model="keyword">

    <div class="hash-tags">
      <div class="hash-tag" v-for="tag in filteredTags" :key="tag.id">
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
      keyword: '',
      tags: []
    }
  },
  mounted () {
    axios
      .get('/api/v1/tags.json')
      .then(response => (this.tags = response.data))
  },

  computed: {
    filteredTags: function() { //検索機能

      var tags = [];

      for(var i in this.tags) {
        var tag = this.tags[i];
        if(tag.name.indexOf(this.keyword) !== -1) {
            tags.push(tag);
        }
      }
      console.log(tags);
      return tags;
    },

  }

}  //export default
</script>

<style lang="scss" scoped>

  input {
    margin-top: 20px;
  }

  .hash-tags {
    margin-top: 30px;
    display : flex;
    flex-wrap: wrap;
    .hash-tag {
      margin: 0 10px 10px 0;
    }
  }

  .background-image {
    img {
      object-position: 0 45%;
    }
  }

</style>