###
Determines if the view is in visible in the browser window.

Example usage:
	Just require the mixin from your component.
	Use the optional offset props like:
	large-copy(in-viewport-offset-top="-100" in-viewport-offset-bottom="100")
###
win = require 'window-event-mediator'

module.exports =

	props: ['inViewportOffsetTop', 'inViewportOffsetBottom']

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

		# Default offsets to 0
		@inViewportOffsetTop = 0 if !@inViewportOffsetTop?
		@inViewportOffsetBottom = 0 if !@inViewportOffsetBottom?

		# Call visibility check on init
		@onScroll()

	detach: ->
		# Unregister handlers
		win.off 'scroll', @onScroll
		win.off 'resize', @onScroll

	watch:
		# Adds the `in-viewport` class when the component is in bounds
		inViewport: (newValue) -> $(@$el).toggleClass 'in-viewport', newValue

	methods:
		onScroll: ->
			# Determine the visibility of the component, including optional offsets
			docViewTop = @$win.scrollTop()
			docViewBottom = docViewTop + @$win.height()
			elemTop = @$el.offset().top + @inViewportOffsetTop
			elemBottom = @$el.offset().top + @$el.outerHeight() + @inViewportOffsetBottom

			@inViewport = (elemTop <= docViewBottom) and (elemBottom >= docViewTop)
