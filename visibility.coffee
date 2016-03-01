# Test if in viewport
#
# @param  DOMELement el
# @param  object     options
# @return            bool
module.exports = isInViewport: (el, options) ->

	# Require an el
	return false if !el

	# Default options
	options = {} if !options
	options.offsetTop = 0 if !options.offsetTop
	options.offsetBottom = 0 if !options.offsetBottom

	# Get Viewport dimensions
	# http://ryanve.com/lab/dimensions/
	vp = {}
	vp.height = document.documentElement.clientHeight
	vp.width  = document.documentElement.clientWidth
	vp.top    = document.body.scrollTop
	vp.bottom = vp.top + vp.height
	vp.left   = document.body.scrollLeft
	vp.right  = vp.left + vp.width

	# Support percentage offsets
	for key in ['offsetTop', 'offsetBottom']
		options[key] = vp.height * options[key] if 0 < Math.abs(options[key]) < 1

	# Get element dimensions with offsets
	vm = el.getBoundingClientRect()

	# Test if in viewport
	vm.top + options.offsetTop <= vp.bottom and
	vm.bottom + options.offsetBottom >= vp.top and
	vm.left <= vp.right and
	vm.right >= vp.left
