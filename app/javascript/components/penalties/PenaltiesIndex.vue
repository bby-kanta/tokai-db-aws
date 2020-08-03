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
    <div class="penalties">
      <div class="penalty" v-for="penalty in penalties" :key="penalty.id">
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
      penalties: []
    }
  },
  mounted () {
    axios
      .get('/api/v1/penalties.json')
      .then(response => (this.penalties = response.data))
  },

}  //export default
</script>

<style lang="scss" scoped>

  .penalties {
    display: flex;
  }

</style>