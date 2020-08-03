<template>

  <div id="nav-drawer">
      <input id="nav-input" type="checkbox" class="nav-unshown">
      <label id="nav-open" for="nav-input"><span></span></label>
      <label class="nav-unshown" id="nav-close" for="nav-input"></label>
      <div id="nav-content">
        <ul>
          <li>
            <router-link :to="{ name: 'VideosIndex' }">
              <i class="fas fa-home"></i>
              トップページ
            </router-link>
          </li>

          <li>
            <a href="https://www.youtube.com/channel/UCutJqz56653xV2wwSvut_hQ">
              <i class="fab fa-youtube"></i>
              東海オンエア
            </a>
          </li>

          <li>
            <a href="https://www.youtube.com/channel/UCynIYcsBwTrwBIecconPN2A">
              <i class="fab fa-youtube"></i>
              控え室
            </a>
          </li>

          <li>
            <router-link :to="{ name: 'PeopleIndex' }">
              <i class="fas fa-users"></i>
              出演者 
            </router-link>
          </li>

          <li>
            <router-link :to="{ name: 'PenaltiesIndex' }">
              <i class="fas fa-skull-crossbones"></i>
              罰ゲーム(十字架) 
            </router-link>
          </li>

          <li>
            <router-link :to="{ name: 'TagsIndex' }">
              <i class="fas fa-hashtag"></i>
              ハッシュタグ 
            </router-link>
          </li>

          <li>
            <router-link :to="{ name: 'PlacesIndex' }">
              <i class="fab fa-fort-awesome"></i>
              撮影場所
            </router-link>
          </li>

          <li>
            <router-link :to="{ name: 'MusicsIndex' }">
              <i class="fas fa-music"></i>
              BGM
            </router-link>
          </li>

          <li>
            <a href="https://www.instagram.com/momotaro928/?hl=ja">
              <i class="fab fa-instagram"></i>
              かんたのインスタ
            </a>
          </li>

        </ul>
      </div>
  </div>

</template>

<script>

export default {

}  //export default
</script>

<style lang="scss" scoped>

ul {
  padding: 0;
  position: relative;
}

ul li {
  line-height: 1.5;
  padding: 0.5em 0.5em 0.5em 1.7em;
  list-style-type: none!important;
  text-shadow: 1px 1px 1px whitesmoke;/*文字を立体的に*/
  color: black;
  background: -webkit-linear-gradient(top,  whitesmoke 100%);/*グラデーション*/
  background: linear-gradient(to bottom, whitesmoke 0%, #dadada 100%);/*グラデーション*/
}

a {
  display: block;
  width: 100%;
  font-size: 25px;
}
a:hover {
  color: red;
}

#nav-drawer {
  position: fixed;
  z-index: 9998;
  top: 31px;  //上からの位置を指定して固定
  left: 15px;
}

/*チェックボックス等は非表示に*/
.nav-unshown {
  display:none;
}

/*アイコンのスペース*/
#nav-open {
  display: inline-block;
  width: 30px;
  height: 22px;
  vertical-align: middle;
}

/*ハンバーガーアイコンをCSSだけで表現*/
#nav-open span, #nav-open span:before, #nav-open span:after {
  position: absolute;
  z-index: 9998;
  height: 3px;/*線の太さ*/
  width: 25px;/*長さ*/
  border-radius: 3px;
  background: #555;
  display: block;
  content: '';
  cursor: pointer;
}
#nav-open span:before {
  bottom: -8px;
}
#nav-open span:after {
  bottom: -16px;
}

/*閉じる用の薄黒カバー*/
#nav-close {
  display: none;/*はじめは隠しておく*/
  position: fixed;
  z-index: 99;
  top: 0;/*全体に広がるように*/
  left: 0;
  width: 100%;
  height: 100%;
  background: black;
  opacity: 0;
  transition: .3s ease-in-out;
}

/*中身*/
#nav-content {
  overflow: auto;
  position: fixed;
  top: 0;
  left: 0;
  z-index: 9999;/*最前面に*/
  width: 90%;/*右側に隙間を作る（閉じるカバーを表示）*/
  max-width: 330px;/*最大幅（調整してください）*/
  height: 100%;
  background: rgb(203, 200, 200);/*背景色*/
  transition: .3s ease-in-out;/*滑らかに表示*/
  -webkit-transform: translateX(-105%);
  transform: translateX(-105%);/*左に隠しておく*/
}

/*チェックが入ったらもろもろ表示*/
#nav-input:checked ~ #nav-close {
  display: block;/*カバーを表示*/
  opacity: .5;
}

#nav-input:checked ~ #nav-content {
  -webkit-transform: translateX(0%);
  transform: translateX(0%);/*中身を表示（右へスライド）*/
  box-shadow: 6px 0 25px rgba(0,0,0,.15);
}
</style>