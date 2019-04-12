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
		
		# The IntersectionObserver root margin adds offsets to when the now and 
		# fully get updated
		inViewportRootMargin: 
			type: Number|String
			default: undefined
			
		# Specify the IntersectionObserver root to use.
		inViewportRoot:
			type: String|Function|Object
			default: undefined

		# The IntersectionObserver threshold defines the intersection ratios that
		# fire the observer callback
		inViewportThreshold: 
			type: Number|Array
			default: -> [0, 1] # Fire on enter/leave and fully enter/leave
		
	# Bindings that are used by the host component
	data: -> inViewport:

		# Public props
		now: null   # Is in viewport
		fully: null # Is fully in viewport
		above: null # Is partially or fully above the viewport
		below: null # Is partially or fully below the viewport

		# Internal props
		listening: false
		maxThreshold: 1

	# Lifecycle hooks
	mounted: -> @$nextTick(@inViewportInit)
	destroyed: -> @removeInViewportHandlers()

	computed:
		
		# Add the maxThreshold to the @inViewportThreshold prop so that the handler
		# is fired for elements that are talled than the viewport
		inViewportThresholdWithMax: ->
			
			# Support number and array thresholds
			threshold = 
				if typeof @inViewportThreshold == 'object'
				then @inViewportThreshold
				else [ @inViewportThreshold ]
			
			# Add only if not already in the threshold list
			if @inViewport.maxThreshold in threshold
			then threshold
			else threshold.concat @inViewport.maxThreshold

	# Watch props and data
	watch:

		# Add or remove event handlers handlers
		inViewportActive: (active) ->
			if active
			then @addInViewportHandlers()
			else @removeInViewportHandlers()

		# If any of the Observer options change, re-init.
		inViewportRootMargin: -> @reInitInViewportMixin()
		inViewportRoot: -> @reInitInViewportMixin()
		inViewportThresholdWithMax: (now, old) -> 
			
			# In IE, this is kept getting retriggered, to doing a manual comparison
			# of old and new before deciding whether to take action.
			@reInitInViewportMixin() unless now.toString() == old.toString()

	# Public API
	methods:

		# Re-init
		reInitInViewportMixin: ->
			@removeInViewportHandlers()
			@inViewportInit()

		# Instantiate
		inViewportInit: -> @addInViewportHandlers() if @inViewportActive

		# Add listeners
		addInViewportHandlers: ->

			# Don't add twice
			return if @inViewport.listening
			@inViewport.listening = true

			# Create IntersectionObserver instance
			@inViewportObserver = new IntersectionObserver @updateInViewport,
				root: switch typeof @inViewportRoot
					when 'function' then @inViewportRoot()
					when 'string' then document.querySelector @inViewportRoot
					when 'object' then @inViewportRoot # Expects to be a DOMElement
					else undefined
				rootMargin: @inViewportRootMargin
				threshold: @inViewportThresholdWithMax
			
			# Start listening
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
		
			# Get the maximum threshold ratio, which is less than 1 when the
			# element is taller than the viewport
			@inViewport.maxThreshold = Math.min 1, 
				entry.rootBounds.height / entry.boundingClientRect.height
				
			# Update state values. It was necessary to include "or equal to" here
			# because the threshold trigger fires when the sites may equal each other.
			# Without this, the appeared stuck when the two tops (for instance) were
			# exactly equal.
			@inViewport.now = entry.isIntersecting
			@inViewport.fully = entry.intersectionRatio >= @inViewport.maxThreshold
			@inViewport.above = entry.boundingClientRect.top <= entry.rootBounds.top
			@inViewport.below = entry.boundingClientRect.bottom >= entry.rootBounds.bottom
						
			# If set to update "once", remove listeners if in viewport
			@removeInViewportHandlers() if @inViewportOnce and @inViewport.now
