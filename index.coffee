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
		inViewport: (newValue) ->
			console.log @newValue
			$(@$el).toggleClass 'in-viewport', newValue

	methods:
		onScroll: ->
			vpWidth   			= @$win.width()
			vpHeight  			= @$win.height()
			viewTop         = @$win.scrollTop()
			viewBottom      = viewTop + vpHeight
			viewLeft        = @$win.scrollLeft()
			viewRight       = viewLeft + vpWidth
			offset          = @$el.offset()
			_top            = (offset.top )
			_bottom         = _top + @$el.height()
			_left           = offset.left
			_right          = _left + @$el.width()
			compareTop      = (_bottom + @inViewportOffsetBottom)
			compareBottom   = (_top + @inViewportOffsetTop)
			compareLeft     = _right
			compareRight    = _left

			console.log _top, _bottom

			@inViewport = ((compareBottom <= viewBottom) and (compareTop >= viewTop)) and ((compareRight <= viewRight) and (compareLeft >= viewLeft))


			console.log @inViewport
