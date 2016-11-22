# Deps
scrollMonitor = require 'scrollmonitor'

# Mixin definition
module.exports =

	# Public interface
	props:

		# Add listeners and check if in viewport immediately
		inViewportActive:
			type: Boolean
			default: true

		# Only update once by default. The assumption is that it will be used for
		# one-time buildins
		inViewportOnce:
			type: Boolean
			default: true

	# Bindings that are used by the host component
	data: ->

		# Store the scrollMonitor instance
		# scrollMonitor: null

		# Scrollmonitor propertoes
		inViewport:
			now: null
			fully: null
			above: null
			below: null

	# Init scrollMonitor as soon as added to the DOM
	mounted: ->
		@scrollMonitor = scrollMonitor.create @$el
		@addInViewportHandlers() if @inViewportActive

	# Cleanup on destroy
	destroyed: ->
		@scrollMonitor.destroy()

	# Public API
	methods:

		# Add listeners
		addInViewportHandlers: ->
			method = if @inViewportOnce then 'on' else 'on'
			@scrollMonitor[method] 'stateChange', @updateInViewport
			@updateInViewport()

		# Handle state changes from scrollMonitor
		updateInViewport: -> @inViewport =
			now:    @scrollMonitor.isInViewport
			fully:  @scrollMonitor.isFullyInViewport
			above:  @scrollMonitor.isAboveViewport
			below:  @scrollMonitor.isBelowViewport
