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
		$el: null

	ready: ->
		# Set Properties
		@$win = $(window)
		@$el = $(@$el)

		# Check visibility on scroll and resize(as layout will change)
		win.on 'scroll', @onScroll
		win.on 'resize', @onScroll

		# Default settings
		@inViewportOnce = true if !@inViewportOnce?

		# Call visibility check on init
		@onScroll()

	beforeDestroy: ->
		@removeHandlers()

	watch:
		# Adds the `in-viewport` class when the component is in bounds
		inViewport: (newValue) ->
			# If the trigger should only happen once, remove the handlers and break
			return @removeHandlers() if (@inViewportOnce and (@$el.hasClass 'in-viewport'))

			$(@$el).toggleClass 'in-viewport', newValue

	methods:
		onScroll: ->
			@inViewport = visibility.isInViewport @$el,
				offsetTop: @inViewportOffsetTop
				offsetBottom: @inViewportOffsetBottom

		removeHandlers: ->
			# Unregister handlers
			win.off 'scroll', @onScroll
			win.off 'resize', @onScroll
