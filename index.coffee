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

	data: ->
		inViewport: false
		$win: null
		$EL: null

	ready: ->
		# Set Properties
		@$win = $(window)
		@$EL = $(@$el)

		# Check visibility on scroll and resize(as layout will change)
		win.on 'scroll', @onInViewportScroll
		win.on 'resize', @onInViewportScroll

		# Default settings
		@inViewportOnce = true if !@inViewportOnce?

		# Call visibility check on init
		@onInViewportScroll()

	beforeDestroy: ->
		@removeHandlers()

	watch:
		# Adds the `in-viewport` class when the component is in bounds
		inViewport: (newValue) ->
			# If the trigger should only happen once, remove the handlers and break
			return @removeHandlers() if (@inViewportOnce and (@$EL.hasClass 'in-viewport'))

			@$EL.toggleClass 'in-viewport', newValue

	methods:
		onInViewportScroll: ->
			@inViewport = visibility.isInViewport @$EL,
				offsetTop: @inViewportOffsetTop
				offsetBottom: @inViewportOffsetBottom

		removeHandlers: ->
			# Unregister handlers
			win.off 'scroll', @onInViewportScroll
			win.off 'resize', @onInViewportScroll
