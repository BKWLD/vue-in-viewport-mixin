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

		# Handle state changes.  There should only ever be one entry and we're
		# destructuring the properties we care about since they have long names.
		updateInViewport: ([{
				boundingClientRect: target,
				rootBounds: root
			}]) ->
		
			# Get the maximum threshold ratio, which is less than 1 when the
			# element is taller than the viewport.  We're reducing the threshold
			# slightly because otherwise some browsers (like IE with polyfill) never
			# reached the threshold when their target was taller than the viewport. I
			# suspect it's a rounding issue.
			@inViewport.maxThreshold = Math.min 1, root.height / target.height * .999
			console.log target, root
			
			# If intersecting, some of the target is within the root rect.
			@inViewport.now = (target.top >= root.top and target.top <= root.bottom) or
			(target.bottom > root.top and target.bottom < root.bottom)

			# Calculate above and below
			@inViewport.above = target.top < root.top
			@inViewport.below = target.bottom > root.bottom + 1
			
			# Determine whether fully in viewport. The rules are different based on
			# whether the target is taller than the viewport.
			@inViewport.fully = if target.height > root.height
			then target.top <= root.top and target.bottom >= root.bottom + 1
			else not @inViewport.above and not @inViewport.below
						
			# If set to update "once", remove listeners if in viewport
			@removeInViewportHandlers() if @inViewportOnce and @inViewport.now
