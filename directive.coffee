###
Directive version of the main mixin
###

# Deps
win = require 'window-event-mediator'
visibility = require './visibility'

# Directive definition
module.exports =

	# Settings
	params: [
		'in-viewport-once'
		'in-viewport-class'
		'in-viewport-offset-top'
		'in-viewport-offset-bottom'
	]

	# Listen for scroll events and set default param values
	bind: ->

		# Default vals
		@params.inViewportOnce = true if !@params.inViewportOnce?
		@params.inViewportClass = 'in-viewport' if !@params.inViewportClass?
		@params.inViewportOffsetTop = 0 if !@params.inViewportOffsetTop?
		@params.inViewportOffsetBottom = 0 if !@params.inViewportOffsetBottom?

		# Callback were losing scope unless I explicitly bound it.  And need to
		# save the reference so it can be effectively unbound.
		@boundOnInViewportScroll = => @onInViewportScroll()
		win.on 'scroll', @boundOnInViewportScroll
		win.on 'resize', @boundOnInViewportScroll
		@onInViewportScroll()

	# Remove listener
	unbind: ->
		win.off 'scroll', @boundOnInViewportScroll
		win.off 'resize', @boundOnInViewportScroll

	# Update viewport staus
	onInViewportScroll: ->
		visible = @isInViewport()
		@unbind() if @params.inViewportOnce and visible
		$(@el).toggleClass(@params.inViewportClass, visible)

	# Check if element is in viewport
	isInViewport: -> visibility.isInViewport @el,
		offsetTop:    @params.inViewportOffsetTop
		offsetBottom: @params.inViewportOffsetBottom
