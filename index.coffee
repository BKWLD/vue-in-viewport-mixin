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
			console.log @inViewportRoot
			@inViewportObserver = new IntersectionObserver @updateInViewport,
				root: switch typeof @inViewportRoot
					when 'function' then @inViewportRoot()
					when 'string' then document.querySelector @inViewportRoot
					when 'object' then @inViewportRoot # Expects to be a DOMElement
					else undefined
				rootMargin: @inViewportRootMargin
				threshold: @inViewportThreshold
			
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
			console.log entry.rootBounds.height / entry.boundingClientRect.height 

			# Update state values
			@inViewport.now = entry.isIntersecting
			@inViewport.fully = entry.intersectionRatio >= 1
			@inViewport.above = entry.boundingClientRect.top < entry.rootBounds.top
			@inViewport.below = entry.boundingClientRect.bottom > entry.rootBounds.bottom

			# If set to update "once", remove listeners if in viewport
			@removeInViewportHandlers() if @inViewportOnce and @inViewport.now
