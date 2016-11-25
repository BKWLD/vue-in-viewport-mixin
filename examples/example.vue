<template>

<div
	class='example'
	:class='classes'>
</div>

</template>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<script lang='coffee'>
inViewport = require 'vue-in-viewport-mixin'
module.exports =

	# Use the miixin that is being tested
	mixins: [ inViewport ]

	# Output the current state for inspection by nightwatch
	computed: classes: ->
		'in-viewport': @inViewport.now
		'fully-in-viewport': @inViewport.fully
		'above-viewport': @inViewport.above
		'below-viewport': @inViewport.below
		active: @inViewportActive

</script>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<style>

body {
	padding: 0;
	margin: 0;
	font-size: 0;
	line-height: 0;
}

.example {
	height: calc(100vh - 50px);
	width: 100vw;
	background: red;
	box-sizing: border-box;

	/**
	 * This 20+1 on the margin was needed because otherwise the second one gets
	 * marked by scroll monitor as initially visible.
	 */
	margin-bottom: 51px;
}

.example:not(.active) {
	opacity: 0.3;
}

.example.visible {
	background: orange;
}

.example.fully {
	background: green;
}

.example.above {
	border-top: 10vh dotted black;
}

.example.below {
	border-bottom: 10vh dotted black;
}

</style>
