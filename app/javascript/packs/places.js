// import Vue from 'vue'
// import PlacesIndex from '../components/places/PlacesIndex.vue';
// import PlacesShow from '../components/places/PlacesShow.vue'

// document.addEventListener('DOMContentLoaded', () => {
//   const el = document.querySelector('.js-places-index')

//   if (el == null) {
//     return
//   }

//   const { notice, places } = el.dataset

//   const props = {
//     notice: notice,
//     places: places ? JSON.parse(places) : [],  //parseメソッドはJSONをJS用に変換して自由に扱えるようにする。
//   }

//   new Vue({
//     el: el,
//     render: h => h(PlacesIndex, { props })
//   }).$mount()
// })

// document.addEventListener('DOMContentLoaded', () => {
//   const el = document.querySelector('.js-places-show')

//   if (el == null) {
//     return
//   }

//   const { name, description, editPlacePath } = el.dataset

//   const props = {
//     name: name,
//     description: description,
//     editPlacePath: editPlacePath,
//   }

//   new Vue({
//     el: el,
//     render: h => h(PlacesShow, { props })
//   }).$mount()
// })