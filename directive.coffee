###
Directive version of the main mixin
###

# Deps
win = require 'window-event-mediator'
visibility = require './visibility'

# Directive definition
module.exports =

	# Global defaults, duck punch to change
	inViewportActive:       true
	inViewportOnce:         true
	inViewportClass:        'in-viewport'
	inViewportOffsetTop:    0
	inViewportOffsetBottom: 0

	# Prop-style settings
	params: [
		'in-viewport-active'
		'in-viewport-once'
		'in-viewport-class'
		'in-viewport-offset-top'
		'in-viewport-offset-bottom'
	]

	# Set default param values and start listening for scrolls
	bind: ->

		# Set defaults from the global defaults
		(@params[key] = @[key] unless @params[key]?) for key in [
			'inViewportActive'
			'inViewportOnce'
			'inViewportClass'
			'inViewportOffsetTop'
			'inViewportOffsetBottom'
		]

		# Callback were losing scope unless I explicitly bound it.  And need to
		# save the reference so it can be effectively unbound.
		@boundOnInViewportScroll = => @onInViewportScroll()

		# If init was delayed, watch for inViewportActive on the parent vm to become
		# true for when it's directives should add their handlers
		if @params.inViewportActive
			@addHandlers()
		else
			@vm.$watch 'inViewportActive', (ready) =>
				@addHandlers() if ready
			, immediate: true

	# Remove listener
	unbind: -> @removeHandlers()

	# Add listeners
	addHandlers: ->
		return if @handlersAdded
		@handlersAdded = true
		win.on 'scroll', @boundOnInViewportScroll
		win.on 'resize', @boundOnInViewportScroll
		@onInViewportScroll()

	# Remove listeners
	removeHandlers: ->
		return unless @handlersAdded
		@handlersAdded = false
		win.off 'scroll', @boundOnInViewportScroll
		win.off 'resize', @boundOnInViewportScroll

	# Update viewport staus
	onInViewportScroll: ->
		visible = @isInViewport()
		@removeHandlers() if @params.inViewportOnce and visible
		$(@el).toggleClass(@params.inViewportClass, visible)

	# Check if element is in viewport
	isInViewport: -> visibility.isInViewport @el,
		offsetTop:    @params.inViewportOffsetTop
		offsetBottom: @params.inViewportOffsetBottom
