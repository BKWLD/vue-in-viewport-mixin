
# Deps
Vue = require 'vue'

# Component that will host the mixin
Vue.component 'example', require './example.vue'

# Init root instance
new Vue
	el: '#app'
