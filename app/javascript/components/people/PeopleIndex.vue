<template>
  <div>

    <div class="title">
      <h3>Characters</h3>
    </div>

    <div class="people-tokai">
      <div class="person-" v-for="person in people" :key="person.id">
        <router-link :to="{ name: 'PeopleShow', params: { id: person.id } }">
          
          <div class="image-person">
            <PeopleImages :person="person.id"></PeopleImages>      
          </div>
          <div class="introduce-person">
            <h3> {{ person.name }} </h3>
            <h4> 出演回数 {{ person.videos.length }} 回 </h4>
            <p> {{ person.description }} </p>
          </div>  

        </router-link>
      </div>
    </div>

  </div>
</template>

<script>
import axios from 'axios';

import PeopleImages from './PeopleImages.vue';

export default {
  components: {
    PeopleImages
  },

  data: function () {
    return {
      people: [],
    }
  },
  mounted () {
    axios
      .get('/api/v1/people.json')
      .then(response => (this.people = response.data))
  },

}  //export default
</script>

<style lang="scss" scoped>

h2 {
  margin-bottom: 1%;
}

.people-tokai{
  margin-top: 6px;
  display: flex;
  flex-wrap: wrap;
  justify-content: space-around;
  align-content: space-around;
  a {
    font-size: 30px;
  }
}

div[class*="person-"] {
  width: 30%;
  min-width: 200px;
  margin-bottom: 3%;
  border: 2px solid rgb(238, 232, 232);
  box-shadow: 2px 2px 2px 4px gray;
  animation: anim-scale 0.5s ease-out;
  transform-origin: 50% 50%;
}
@keyframes anim-scale {
  0% { transform: scale(0.4, 0.4); }
  40% { transform: scale(1.2, 1.2); }
  60% { transform: scale(1, 1); }
  80% { transform: scale(1.1, 1.1); }
  100% { transform: scale(1, 1); }
}

div[class*="person-"] img {
  width: 100%;
  border-radius: 50%;
}

div[class*="person-"] p {
  font-size: 0.5em;
  overflow: hidden;
  height: 5.4em;
  line-height: 1.8;
}

.image-person{
  padding: 7% 7% 0 7%;
}

.introduce-person { //記事の写真の下の部分
  padding: 0 5% 5% 5%;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
}
.introduce-person h4 { //出演回数
  margin: 0;
  font-size: 0.5em;
}

.people-sub { //出演者一覧のdiv
  display: flex;
  flex-wrap: wrap;
}
.people-sub a{ //出演者の a タグ
  margin: 0 20px 20px 0;
}

@media screen and (max-width: 999px){ //widthが999pxまでのCSS(スマホ用)
  .people-tokai{
    flex-wrap: nowrap;
    flex-direction: column;

    a {
      font-size: 30px;
    }
  }

  div[class*="person-"] {
    width: 100%;
  }

}
</style>