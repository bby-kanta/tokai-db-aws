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

    <div class="search-box">
      <input type="text" v-model="keyword" placeholder="ハッシュタグ検索">
      <select v-model="personSelect">
        <option value=''>メンバー名</option>
        <option value=1>てつや</option>
        <option value=2>しばゆー</option>
        <option value=3>りょう</option>
        <option value=4>としみつ</option>
        <option value=5>ゆめまる</option>
        <option value=6>虫眼鏡</option>
        <option value=7>共通タグ</option>
      </select>
    </div>

    <div class="hash-tags">
      <div class="hash-tag" v-for="tag in filteredTags" :key="tag.id">
        <TagColor :person="tag.person_id" :tag_id="tag.id" :tag_name="tag.name" :count="'('+ tag.tag_videos_count +')' "></TagColor>
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
      tags: [],
      keyword: '',
      personSelect: '',
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
        if(tag.name.indexOf(this.keyword) !== -1 |
           tag.sort.indexOf(this.keyword) !== -1 &&
           this.personSelect == '' | tag.person_id == this.personSelect
        ) {
            tags.push(tag);
        }
      }
      return tags;
    },

  }

}  //export default
</script>

<style lang="scss" scoped>

.search-box {
  margin-top: 20px;
  display: flex;
  input {
    width: 20%;
  }
  select {
    margin-left: 10px;
  }
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