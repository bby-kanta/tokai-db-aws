<template>
  <div id="app">

    <div class="subscriber-counter"> <!-- チャンネル登録者数を表示する -->
      <h2>チャンネル登録者数</h2>
      <h1> {{ count }} </h1>
    </div>

    <div class="view-counter">
      <h2>チャンネル総再生数</h2>
      <h1> {{ count2 }} </h1>
    </div>

  </div>
</template>

<script>
import axios from 'axios';
import anime from 'animejs/lib/anime.es.js';

export default {

  data: function () {
    return {
      count: '',
      count2: '',
      youtube:{
        items: [{
          statistics: {
            subscriberCount:'', //空で定義しとかないと読み込まれた時に一瞬consoleにエラーが出る
          }
        }]
      },
    }
  },

  async mounted () {
    await axios
      .get(`https://www.googleapis.com/youtube/v3/channels?part=statistics&id=UCutJqz56653xV2wwSvut_hQ&key=AIzaSyDovZVx44zT7JglmnHzWoeUeXDrQra4CVg`)
      .then(response => (this.youtube = response.data));

    this.setCount(this.youtube.items[0].statistics.subscriberCount)
    this.setCount2(this.youtube.items[0].statistics.viewCount)
  },

  computed: {

  },

  methods: {
    setCount (val) {
      const obj = { n: this.count }
      anime({
        targets: obj,
        n: val,
        round: 1,
        duration: 1500,  //秒数
        easing: 'linear',
        update: () => {
          this.count = obj.n
        }
      })
    },
    setCount2 (val) {
      const obj = { n: this.count2 }
      anime({
        targets: obj,
        n: val,
        round: 1,
        duration: 1500,  //秒数
        easing: 'linear',
        update: () => {
          this.count2 = obj.n
        }
      })
    },

  }
}

</script>

<style lang="scss" scoped>

#app {
  width: 100%;
  display: flex;
  justify-content:space-around;
}

.subscriber-counter , .view-counter {
  display: flex;
  flex-direction: column;
  align-items: center;
  h1 {  //https://1-notes.com/css-text-design/
    font-size:5em;
    text-align:center;
    line-height:0.95em;
    font-weight:bold;
    color: transparent;
    background: repeating-linear-gradient(45deg,
        #F5B090 0.1em 0.2em,
        #FCD7A1 0.2em 0.3em,
        #FFF9B1 0.3em 0.4em,
        #A5D4AD 0.4em 0.5em,
        #A3BCE2 0.5em 0.6em,
        #A59ACA 0.7em 0.8em,
        #CFA7CD 0.8em 0.9em);
    -webkit-background-clip: text;
  }
}

@media screen and (max-width: 999px){ /*widthが999pxまでのCSS(スマホ用)*/
  #app {
    display: none;
  }
}

</style>