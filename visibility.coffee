# Test if in viewport
#
# @param  DOMELement el
# @param  object     options
# @return            bool
module.exports = isInViewport: (el, options) ->

	# Require an el
	return false if !el

	# Make defaults
	options = {} if !options?
	options.offsetTop = 0 if !options.offsetTop?
	options.offsetBottom = 0 if !options.offsetBottom?

	# Get Viewport dimensions
	# http://ryanve.com/lab/dimensions/
	vp = {}
	vp.top =    document.body.scrollTop
	vp.bottom = vp.top + document.documentElement.clientHeight
	vp.left =   document.body.scrollLeft
	vp.right =  vp.left + document.documentElement.clientWidth

	# Get element dimensions with offsets
	vm          = el.getBoundingClientRect()
	vm.top     += options.offsetTop
	vm.bottom  += options.offsetBottom

	# Test if in viewport
	vm.top <= vp.bottom and
	vm.bottom >= vp.top and
	vm.left <= vp.right and
	vm.right >= vp.left
