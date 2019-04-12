# Vue In Viewport Mixin [![Build Status](https://travis-ci.org/BKWLD/vue-in-viewport-mixin.svg?branch=master)](https://travis-ci.org/BKWLD/vue-in-viewport-mixin)

Vue 2 mixin to determine when a DOM element is visible in the client window by updating Vue data values using the [IntersectionObserver](https://developer.mozilla.org/en-US/docs/Web/API/IntersectionObserver).  You can then use those data values to do things like trigger transitions.

You may want to check out the directive vesion of this package: [vue-in-viewport-directive](https://github.com/BKWLD/vue-in-viewport-directive).

Demo: https://bkwld.github.io/vue-in-viewport-mixin

# Install

This package depends on the [IntersectionObserver](https://developer.mozilla.org/en-US/docs/Web/API/IntersectionObserver) API which needs a polyfill for old browsers, including all of IE.  Consider using the [W3C IntersectionObserver polyfill](https://github.com/w3c/IntersectionObserver/tree/master/polyfill).


## Usage

* Just require the mixin from your component and use it with `watch`:
	```js
	inViewport = require('vue-in-viewport-mixin');
	module.exports = {
		mixins: [ inViewport ],
		watch: {
			'inViewport.now': function(visible) {
				console.log('This component is '+( visible ? 'in-viewport' : 'hidden'));
			}
		}
	}
	```

* Use the optional offset props to configure the component:
	```html
	<large-copy
		:in-viewport-root-margin='-50% 0%'
		:in-viewport-once='true'>
	</large-copy>
	```

* Use data values _within_ your component to trigger transitions (or do other things):
	```html
	<div class='.large-copy'>
		<transition name='fade'>
			<h1 v-show='inViewport.now'>{{ copy.title }}</h1>
		</transition>
	</div>
	```
	
* It's worth nothing that the IntersectionObserver counts an element as intersecting the viewport when it's top offset is equal to the height of height of the page.  For instance, if you have an element with `margin-top: 100vh`, that actually counts as intersecting and this mixin will have `inViewport.now == true`.

## Props

- `in-viewport-active (true)` - Whether to listen update the mixin data.  Setting to `false` later in the lifecyle will remove listeners and setting back to `true` will re-apply listeners.

- `in-viewport-once (false)` - Whether to remove listeners once the component enters viewport.  If the component is in viewport when mounted, listeners are never added.

- `in-viewport-root-margin (0px 0px -1px 0px)` - Specify the [IntersectionObserver rootMargin](https://developer.mozilla.org/en-US/docs/Web/API/IntersectionObserver/IntersectionObserver#Parameters).  For example, set to "-20% 0%" to delay the `inViewport.now` from switching state until your component is 20% of the viewport height into the page. This defaults to `0px 0px -1px 0px` so that a target that is positioned at `100vh` registers as not in viewport.

- `in-viewport-root` - Specify the [IntersectionObserver root](https://developer.mozilla.org/en-US/docs/Web/API/IntersectionObserver/IntersectionObserver#Parameters).  Defaults to the browser viewport.

- `in-viewport-threshold ([0,1])` - Specify the [IntersectionObserver threshold](https://developer.mozilla.org/en-US/docs/Web/API/IntersectionObserver/IntersectionObserver#Parameters).  The defaults should work for most cases.

## Data

The whole point of this package is for you to make use of this data to do stuff. The following describes the data that is mixed into your component.  Note that all properties are namespaced under `inViewport`.

```js
data: {
	inViewport: {
		now: Boolean   // Is some part of the component currently in the viewport?
		fully: Boolean // Is the component completely in the viewport?
		above: Boolean // Is any part of the component above the viewport?
		below: Boolean // Is any part of the component below the viewport?
	}
}
```

## Tests

1. Start Storybook: `yarn storybook`
2. Open Cypress: `yarn cypress open`

The Travis tests that run on deploy run against [the demo site](https://bkwld.github.io/vue-in-viewport-mixin) which gets updated as part of the `npm version` commands.