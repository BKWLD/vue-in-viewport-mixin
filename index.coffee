###
Determines if the view is in visible in the browser window.

Example usage:
	Just require the mixin from your component.
	Use the optional offset props like:

	large-copy(
		:in-viewport-offset-top="300"
		:in-viewport-offset-bottom="0"

		# Only add the `in-viewport` class once per page load
		:in-viewport-once="false"
	)

###
win = require 'window-event-mediator'
visibility = require './visibility'

module.exports =

	props: [
		'inViewportOffsetTop'
		'inViewportOffsetBottom'
		'inViewportOnce'
	]

	# Boolean stores whether component is in viewport
	data: -> inViewport: false

	ready: ->

		# Cache vars
		@$EL = $(@$el)

		# Check visibility on scroll and resize(as layout will change)
		win.on 'scroll', @onInViewportScroll
		win.on 'resize', @onInViewportScroll

		# Default settings
		@inViewportOnce = true if !@inViewportOnce?

		# Call visibility check on init
		@onInViewportScroll()

	# If comonent is destroyed, clean up listeners
	beforeDestroy: -> @removeHandlers()

	# Adds the `in-viewport` class when the component is in bounds
	watch: inViewport: (bool) ->

		# If the trigger should only happen once, remove the handlers and break
		return @removeHandlers() if @inViewportOnce and bool

		# Toggle class
		@$EL.toggleClass 'in-viewport', bool

	methods:

		# Update viewport status on scroll
		onInViewportScroll: ->
			@inViewport = visibility.isInViewport @$EL,
				offsetTop: @inViewportOffsetTop
				offsetBottom: @inViewportOffsetBottom

		# Unregister handlers
		removeHandlers: ->
			win.off 'scroll', @onInViewportScroll
			win.off 'resize', @onInViewportScroll
