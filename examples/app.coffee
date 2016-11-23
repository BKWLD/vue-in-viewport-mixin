
# Deps
Vue = require 'vue'

# Component that will host the mixin
Vue.component 'example', require './example.vue'

# Init root instance
window.App = new Vue

	el: '#app'

	# The active value is used by the "delayed" test and will be disabled
	# initially
	data:
		active: false
		firstOffsetTop: -100
		firstOffsetBottom: -100
		secondOffsetTop: 100

	methods:

		# Toggle the active state
		toggleActive: -> @active = !@active

		# Reset offsets
		resetOffsets: ->
			@firstOffsetTop = 0
			@firstOffsetBottom = 0
			@secondOffsetTop = 0
