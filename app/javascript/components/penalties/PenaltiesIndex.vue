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
    <div class="search-box">
      <input type="text" v-model="keyword" placeholder="罰ゲーム検索">
      <select v-model="personSelect">
        <option value=''>メンバー名</option>
        <option value=1>てつや</option>
        <option value=2>しばゆー</option>
        <option value=3>りょう</option>
        <option value=4>としみつ</option>
        <option value=5>ゆめまる</option>
        <option value=6>虫眼鏡</option>
      </select>
    </div>

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
      penalties: [],
      keyword: '',
      personSelect: '',
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
        var penalty = this.penalties[i];
        if(penalty.name.indexOf(this.keyword) !== -1 &&
           this.personSelect == '' | penalty.person_id == this.personSelect
        ) {
            penalties.push(penalty);
        }
      }
      return penalties;
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

.penalties {
  margin-top: 10px;
  display: flex;
  flex-wrap: wrap;
  .penalty {
    margin: 0 10px 10px 0;
  }
}

</style>