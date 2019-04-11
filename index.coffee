# Mixin definition
export default

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
		
		# Specify the container to use
		inViewportContainer:
			type: String
			default: null

		# Shared offsets
		inViewportOffset:
			type: Number
			default: 0
		inViewportOffsetTop:
			type: Number
			default: null
		inViewportOffsetBottom:
			type: Number
			default: null

	# Bindings that are used by the host component
	data: -> inViewport:

		# Public props
		now: null   # Is in viewport
		fully: null # Is fully in viewport
		above: null # Is partially or fully above the viewport
		below: null # Is partially or fully below the viewport

		# Internal props
		listening: false

	# Use general offset if none are defined
	computed:
		inViewportOffsetTopComputed: -> @inViewportOffsetTop ? @inViewportOffset
		inViewportOffsetBottomComputed: -> @inViewportOffsetBottom ? @inViewportOffset
		inViewportOffsetComputed: ->
			top: @inViewportOffsetTopComputed
			bottom: @inViewportOffsetBottomComputed

	# Lifecycle hooks
	mounted: -> @$nextTick(@inViewportInit)
	destroyed: -> @removeInViewportHandlers()

	# Watch props and data
	watch:

		# Add or remove event handlers handlers
		inViewportActive: (active) ->
			if active
			then @addInViewportHandlers()
			else @removeInViewportHandlers()

		# If the offsets change, need to re-init the observer
		inViewportOffsetComputed:
			deep: true
			handler: ->
				@removeInViewportHandlers()
				@inViewportInit()

	# Public API
	methods:

		# Instantiate
		inViewportInit: -> @addInViewportHandlers() if @inViewportActive

		# Add listeners
		addInViewportHandlers: ->

			# Don't add twice
			return if @inViewport.listening
			@inViewport.listening = true

			# Create IntersectionObserver instance
			@inViewportObserver = new IntersectionObserver @updateInViewport,
				root: undefined
				rootMargin: undefined
				threshold: undefined
			
			# Add handler
			@inViewportObserver.observe @$el

		# Remove listeners
		removeInViewportHandlers: ->

			# Don't remove twice
			return unless @inViewport.listening
			@inViewport.listening = false
			
			# Destroy instance, which also removes listeners
			@inViewportObserver?.disconnect()
			delete @inViewportObserver

		# Handle state changes from scrollMonitor.  There should only ever be one
		# entry
		updateInViewport: ([entry]) ->
			console.log entry

			# Update state values
			@inViewport.now = entry.isIntersecting
			@inViewport.fully = entry.intersectionRatio == 1
			# @inViewport.above = @scrollMonitor.isAboveViewport
			# @inViewport.below = @scrollMonitor.isBelowViewport

			# If set to update "once", remove listeners if in viewport
			@removeInViewportHandlers() if @inViewportOnce and @inViewport.now
