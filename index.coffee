###
Determines if the view is in visible in the browser window.

Example usage:
	Just require the mixin from your component.
	Use the optional offset props like:

	large-copy(
		:in-viewport-offset-top="300"
		:in-viewport-offset-bottom="0.5"

		# Only add the `in-viewport` class once per page load
		:in-viewport-once="false"
	)

###

# Deps
win = require 'window-event-mediator'
check = require './check'

# Mixin definiton
module.exports =

	# Settings
	props:

		# Add listeners and check if in viewport immediately
		inViewportActive:
			type: 'Boolean'
			default: true

		# Whether to only update in-viewport class once
		inViewportOnce:
			type: 'Boolean'
			default: true

		# Whether to only update in-viewport class once
		inViewportClass:
			type: 'string'
			default: 'in-viewport'

		# Whether to only update in-viewport class once
		inViewportEntrelyClass:
			type: 'string'
			default: 'in-viewport-entirely'

		# A positive offset triggers "late" when scrolling down
		inViewportOffsetTop:
			type: Number
			default: 0

		# A negative offset triggers "early" when scrolling down
		inViewportOffsetBottom:
			type: Number
			default: 0

	# Boolean stores whether component is in viewport
	data: ->
		inViewport: false
		inViewportEntirely: false
		aboveViewport: false
		belowViewport: false

	# Add handlers when vm is added to dom unless init is false
	ready: -> @addInViewportHandlers() if @inViewportActive

	# If comonent is destroyed, clean up listeners
	destroyed: -> @removeInViewportHandlers()

	# Vars to watch
	watch:

		# Adds handlers if they weren't added at runtime
		inViewportActive: (ready) ->
			@addInViewportHandlers() if ready

		# Adds the `in-viewport` class when the component is in bounds/
		inViewport: (visible) ->
			@removeInViewportHandlers() if @inViewportOnce and visible
			$(@$el).toggleClass(@inViewportClass, visible) if @inViewportClass

		# Adds the `in-viewport-entirely` class when the component is in bounds
		inViewportEntirely: (visible) ->
			$(@$el).toggleClass(@inViewportEntrelyClass, visible) if @inViewportEntrelyClass

	# Public API
	methods:

		# Run the check function and map it's response to our data attributes
		onInViewportScroll: ->
			@[prop] = val for prop, val of check @$el,
				offsetTop:    @inViewportOffsetTop
				offsetBottom: @inViewportOffsetBottom

		# Add listeners
		addInViewportHandlers: ->
			return if @inViewportHandlersAdded
			@inViewportHandlersAdded = true
			win.on 'scroll', @onInViewportScroll, throttle: 0
			win.on 'resize', @onInViewportScroll
			@onInViewportScroll()

		# Remove listeners
		removeInViewportHandlers: ->
			return unless @inViewportHandlersAdded
			@inViewportHandlersAdded = false
			win.off 'scroll', @onInViewportScroll
			win.off 'resize', @onInViewportScroll

		###
		# Public API for invoking visibility tests
		###

		# Check if the element is visible at all in the viewport
		isInViewport: (el, options) ->
			check(el, options).inViewport

		# Check if the elemetn is entirely visible in the viewport
		isInViewportEntirely: (el, options) ->
			check(el, options).isInViewportEntirely
