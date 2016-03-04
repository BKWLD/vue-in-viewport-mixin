# Vue In Viewport Mixin


Vue mixin to determine when a DOM element is visible in the client window

Example usage:
* Just require the mixin from your component.
* Use the optional offset props with the `:` [dynamic syntax](http://vuejs.org/guide/components.html#Literal_vs-_Dynamic) so the value is parsed as a JS number.  Numbers between 0 and 1 are treated like percentages of the page height.
	```
	large-copy(:in-viewport-offset-top="-100" :in-viewport-offset-bottom="0.5")
	```

### Directive version

There is also a directive you can use.  For example:

```coffee
Vue.directive 'in-viewport', require 'vue-in-viewport-mixin/directive'
```
```jade
section(v-in-viewport
	in-viewport-class='in-viewport'
	:in-viewport-offset-top='-100'
	:in-viewport-offset-bottom='0.5'
	:in-viewport-once='false')
```
