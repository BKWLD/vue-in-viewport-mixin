# Vue In Viewport Mixin [![Build Status](https://travis-ci.org/BKWLD/vue-in-viewport-mixin.svg?branch=master)](https://travis-ci.org/BKWLD/vue-in-viewport-mixin)

Vue 2 mixin to determine when a DOM element is visible in the client window by updating Vue data values.  You can then use those data values to do things like trigger transitions.

You may want to check out the directive vesion of this package: (vue-in-viewport-directive)[https://github.com/BKWLD/vue-in-viewport-directive].

It wraps [scrollMonitor](https://github.com/stutrek/scrollMonitor) to make registering event listeners light and to do the in viewport calculations.

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
		:in-viewport-offset-top='-100'
		:in-viewport-once='true'>
	</large-copy>
	```

* Use data values _within_ your component to trigger transitions (or do other things):
	```html
	<div class='.large-copy'>
		<transition name='fade'>
			<h1 v-if='inViewport.now'>{{ copy.title }}</h1>
		</transition>
	</div>
	```

## Props

- `in-viewport-active (true)` - Whether to listen update the mixin data.  Setting to `false` later in the lifecyle will remove listeners and setting back to `true` will re-apply listeners.
- `in-viewport-once (false)` - Whether to remove listeners once the component enters viewport.  If the component is in viewport when mounted, listeners are never added.
- `in-viewport-offset (0)` - Sets both `in-viewport-offset-top` and `in-viewport-offset-bottom`
- `in-viewport-offset-top` - A positive number will make the vm trigger being in the viewport early, before it's actually scrolls into position.  A negative value will do the opposite.
- `in-viewport-offset-bottom` - See `in-viewport-offset-top`.

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

## Contributing

- Run the examples server with `PORT=3000 node examples/server` and go to an example to see the source for the E2E tests.  Like http://localhost:3000/basic/.
- Run `yarn test` to run E2E tests.
