import Vue from 'vue'
import PlacesShow from '../components/places/PlacesShow.vue'

document.addEventListener('DOMContentLoaded', () => {
  const el = document.querySelector('.js-places-show')

  if (el == null) {
    return
  }

  const { name, description, editPlacePath } = el.dataset

  const props = {
    name: name,
    description: description,
    editPlacePath: editPlacePath,
  }

  new Vue({
    el: el,
    render: h => h(PlacesShow, { props })
  }).$mount()
})

