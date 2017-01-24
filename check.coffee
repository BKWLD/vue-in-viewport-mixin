###
# vm - the view instance
# vp - the viewport
###

# Test that the vm is partially in the viewport
inViewport = (vm, vp, options) ->
	vm.top + options.offsetTop <= vp.height and
	vm.bottom + options.offsetBottom >= 0 and
	vm.left <= vp.width and
	vm.right >= 0

# Test that the vm is entirely in the viewport
inViewportEntirely = (vm, vp, options) ->
	vm.top + options.offsetTop >= 0 and
	vm.bottom + options.offsetBottom <= vp.height and
	vm.left >= 0 and
	vm.right <= vp.width

# Test that the vm is above the viewport
aboveViewport = (vm, vp, options) ->
	(vm.top + vp.height) + options.offsetBottom <= vp.height

# Test that the vm is below the viewport
belowViewport = (vm, vp, options) ->
	vm.bottom + options.offsetTop >= vp.height

# Reusable empty response
nope =
	inViewport: false
	inViewportEntirely: false
	aboveViewport: false
	belowViewport: false

# Returns an object containing measurements on whether the vm relative to the
# viewport.
module.exports = (el, options) ->

	# Require an el
	return nope if !el

	# Default options
	options = {} if !options
	options.offsetTop = 0 if !options.offsetTop
	options.offsetBottom = 0 if !options.offsetBottom

	# Get Viewport dimensions
	# http://ryanve.com/lab/dimensions/
	vp = {}
	vp.height = document.documentElement.clientHeight
	vp.width  = document.documentElement.clientWidth

	# Support percentage offsets
	for key in ['offsetTop', 'offsetBottom']
		options[key] = vp.height * options[key] if 0 < Math.abs(options[key]) < 1

	# Get element dimensions with offsets
	vm = el.getBoundingClientRect()
	return nope if vm.width == 0 && vm.height == 0 # Like if display: none

	# Return object containing measurements
	inViewport:         inViewport(vm, vp, options)
	inViewportEntirely: inViewportEntirely(vm, vp, options)
	aboveViewport: 			aboveViewport(vm, vp, options)
	belowViewport: 			belowViewport(vm, vp, options)
