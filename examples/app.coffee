
# Deps
Vue = require 'vue'

# Component that will host the mixin
Vue.component 'example', require './example.vue'

# Init root instance
window.App = new Vue

	el: '#app'

	# The active value is used by the "delayed" test and will be disabled
	# initially
	data: active: false

	# Toggle the active state
	methods: toggleActive: -> @active = !@active
