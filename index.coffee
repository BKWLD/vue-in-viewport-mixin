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

	# Settings
	props:

		# Add listeners and check if in viewport immediately
		inViewportInit:
			type: 'Boolean'
			default: true

		# Whether to only update in-viewport class once
		inViewportOnce:
			type: 'Boolean'
			default: true

		# A positive offset triggers "late" when scrolling down
		inViewportOffsetTop:
			type: Number
			default: 0

		# A negative offset triggers "early" when scrolling down
		inViewportOffsetBottom:
			type: Number
			default: 0

	# Boolean stores whether component is in viewport
	data: -> inViewport: false

	# On added to DOM...
	ready: ->
		@$EL = $(@$el)  # Cache jQuery selector
		@addInViewportHandlers() if @inViewportInit # Whether to autorun

	# If comonent is destroyed, clean up listeners
	beforeDestroy: -> @removeInViewportHandlers()

	# Adds the `in-viewport` class when the component is in bounds
	watch: inViewport: (bool) ->

		# If the trigger should only happen once, remove the handlers and break
		return @removeInViewportHandlers() if @inViewportOnce and bool

		# Toggle class
		@$EL.toggleClass 'in-viewport', bool

	# Public API
	methods:

		# Update viewport status on scroll
		onInViewportScroll: ->
			@inViewport = visibility.isInViewport @$EL,
				offsetTop: @inViewportOffsetTop
				offsetBottom: @inViewportOffsetBottom

		# Add the handlers
		addInViewportHandlers: ->
			win.on 'scroll', @onInViewportScroll
			win.on 'resize', @onInViewportScroll
			@onInViewportScroll()

		# Unregister handlers
		removeInViewportHandlers: ->
			win.off 'scroll', @onInViewportScroll
			win.off 'resize', @onInViewportScroll
