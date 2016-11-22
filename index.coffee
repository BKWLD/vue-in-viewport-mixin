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
			default: false

	# Bindings that are used by the host component
	data: -> inViewport:
		now: null   # Is in viewport
		fully: null # Is fully in viewport
		above: null # Is partially or fully above the viewport
		below: null # Is partially or fully below the viewport

	# Init scrollMonitor as soon as added to the DOM
	mounted: ->
		@scrollMonitor = scrollMonitor.create @$el
		@addInViewportHandlers() if @inViewportActive

	# Cleanup on destroy
	destroyed: -> @scrollMonitor.destroy()

	# Public API
	methods:

		# Add listeners
		addInViewportHandlers: ->

			# Don't add twice
			return if @inViewport.listening
			@inViewport.listening = true

			# Add appropriate listeners bacsed on `once` prop
			method = if @inViewportOnce then 'one' else 'on'
			@scrollMonitor[method] 'stateChange', @updateInViewport

			# Trigger an immediate update
			@updateInViewport()

		# Remove listeners
		removeInViewportHandlers: ->

			# Don't remove twice
			return unless @inViewport.listening
			@inViewport.listening = false

			# Remove listeners
			@scrollMonitor.off 'stateChange', @updateInViewport

		# Handle state changes from scrollMonitor
		updateInViewport: -> @inViewport =
			now:    @scrollMonitor.isInViewport
			fully:  @scrollMonitor.isFullyInViewport
			above:  @scrollMonitor.isAboveViewport
			below:  @scrollMonitor.isBelowViewport
