# Vue In Viewport Mixin


Vue mixin to determine when a DOM element is visible in the client window

Example usage:
* Just require the mixin from your component.

* Use the optional offset props with the `:` [dynamic syntax](http://vuejs.org/guide/components.html#Literal_vs-_Dynamic) so the value is parsed as a JS number 
	```
	large-copy(:in-viewport-offset-top="-100" :in-viewport-offset-bottom="100")
	```
