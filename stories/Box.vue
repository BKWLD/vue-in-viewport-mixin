<!--
An example box that uses the in-viewport-mixin
-->

<template>

<ul class="box">
	<li>inViewport.now: <b>{{ inViewport.now ? 'Yes' : 'No' }}</b></li>
	<li>inViewport.fully: <b>{{ inViewport.fully ? 'Yes' : 'No' }}</b></li>
	<li>inViewport.above: <b>{{ inViewport.above ? 'Yes' : 'No' }}</b></li>
	<li>inViewport.below: <b>{{ inViewport.below ? 'Yes' : 'No' }}</b></li>
</ul>

</template>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<script>
import inViewport from '../index.coffee'
export default {
	mixins: [inViewport]
}
</script>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<style scoped>

.box {
	
	/* Make a box */
	width: 300px;
	background: grey;
	padding: 10px 30px;
	
	/* Stroybook font styles */
	-webkit-font-smoothing: antialiased;
	font-family: "Nunito Sans",-apple-system,".SFNSText-Regular","San Francisco",BlinkMacSystemFont,"Segoe UI","Helvetica Neue",Helvetica,Arial,sans-serif;
	color: white;
	line-height: 1.4;
}

</style>