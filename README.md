# Vue In Viewport Mixin [![Build Status](https://travis-ci.org/BKWLD/vue-in-viewport-mixin.svg?branch=2.x)](https://travis-ci.org/BKWLD/vue-in-viewport-mixin)

Vue mixin to determine when a DOM element is visible in the client window by updating Vue data values.  You can then use those data values to do things like trigger transitions.

It wraps [scrollMonitor](https://github.com/stutrek/scrollMonitor) to make registering event listeners light and to do the in viewport calculations.

## Usage

* Just require the mixin from your component and use it with `watch`:
	```js
	inViewport = require('vue-in-viewport-mixin');
	module.exports = {
		mixins: [ inViewport ],
		watch: {
			'inViewport.now': function(visible) {
				console.log('This component is '+( visible ? 'visible' : 'hidden'));
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

* Use data values _within_ your component to trigger transitions (or do othter things):
	```html
	<div class='.large-copy'>
		<transition name='fade'>
			<h1 v-if='inViewport.now'>{{ copy.title }}</h1>
		</transition>
	</div>
	```

## Props

- `in-viewport-active (true)` - Whether to listen update the mixin data.  Setting to `false` later in the lifecyle will remove listeners and setting back to `true` will re-apply listeners.
- `in-viewport-once (false)` - Whether to remove listeners once the first event.
- `in-viewport-offset (0)` - Sets both `in-viewport-offset-top` and `in-viewport-offset-bottom`
- `in-viewport-offset-top` - A positive number will make the vm trigger being in the viewport early, before it's actually scrolls into position.  A negative value will do the opposite.
- `in-viewport-offset-bottom` - See `in-viewport-offset-top`.

## Data

The whole point of this package is for you to make use of this data to do stuff. The following describes the data that is mixed into your component.  Note that all properties are namespaced under `inViewport`.

```js
data: {
	inViewport: {
		now: Boolean   // Is the component currently in the viewport?
		fully: Boolean // Is the component completely in the viewport?
		above: Boolean // Is any part of the component above the viewport?
		below: Boolean // Is any part of the component below the viewport?
	}
}
```

## Contributing

- Run the examples server with `PORT=3000 node ./server` and go to an example to see the source for the E2E tests.  Like http://localhost:3000/basic/.
- Run `yarn test` to run E2E tests.
