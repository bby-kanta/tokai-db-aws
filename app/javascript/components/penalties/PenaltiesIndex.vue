<template>

<div>

  <div class="background-image">
    <img src="../../../assets/images/tokai-onair.png">
  </div>

  <div class="background-title">
    <div class="background-title-column">
      <h3>Penalties</h3>
      <h2>罰ゲーム（十字架）</h2>
    </div>
  </div>

  <div class="width-96">
    <input type="text" v-model="keyword">
    <div class="penalties">
      <div class="penalty" v-for="penalty in filteredPenalties" :key="penalty.id">
        <PenaltyColor :person="penalty.person_id" :penalty_id="penalty.id" :penalty_name="penalty.name" :count=" '(' + penalty.videos.length + ')' "></PenaltyColor>
      </div>
    </div>
  </div>

</div>

</template>

<script>
import axios from 'axios';

import PenaltyColor from '../PenaltyColor.vue';

export default {
  components: {
    PenaltyColor
  },

  data: function () {
    return {
      keyword: '',
      penalties: []
    }
  },
  mounted () {
    axios
      .get('/api/v1/penalties.json')
      .then(response => (this.penalties = response.data))
  },
  computed: {
    filteredPenalties: function() { //検索機能

      var penalties = [];

      for(var i in this.penalties) {
        var tag = this.penalties[i];
        if(tag.name.indexOf(this.keyword) !== -1) {
            penalties.push(tag);
        }
      }
      console.log(penalties);
      return penalties;
    },

  }

}  //export default
</script>

<style lang="scss" scoped>

  input {
    margin-top: 20px;
  }

  .penalties {
    margin-top: 10px;
    display: flex;
    flex-wrap: wrap;
    .penalty {
      margin: 0 10px 10px 0;
    }
  }

</style>