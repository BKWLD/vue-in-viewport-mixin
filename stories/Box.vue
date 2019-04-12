<!--
An example box that uses the in-viewport-mixin
-->

<template>

<div class="box">
	<ul class="status">
		<li>inViewport.now: 
			<b data-cy='now'>{{ inViewport.now ? 'Yes' : 'No' }}</b>
		</li>
		<li>inViewport.fully: 
			<b data-cy='fully'>{{ inViewport.fully ? 'Yes' : 'No' }}</b>
		</li>
		<li>inViewport.above: 
			<b data-cy='above'>{{ inViewport.above ? 'Yes' : 'No' }}</b>
		</li>
		<li>inViewport.below: 
			<b data-cy='below'>{{ inViewport.below ? 'Yes' : 'No' }}</b>
		</li>
	</ul>
</div>

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
	width: 300px;
	height: 200px;
	background: linear-gradient(#39d6d4, #1ca7fd)
}

.status {	
	position: fixed;
	top: 0;
	right: 0;
	background: #F6F9FC;
	list-style: none;
	padding: 10px;
	margin: 0;
	
	-webkit-font-smoothing: antialiased;
	font-family: "Nunito Sans",-apple-system,".SFNSText-Regular","San Francisco",BlinkMacSystemFont,"Segoe UI","Helvetica Neue",Helvetica,Arial,sans-serif;
	line-height: 1.4;
	font-size: 13px;
	text-align: right;
}

</style>