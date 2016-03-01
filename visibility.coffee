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

	# Support percentage offsets
	for key in ['offsetTop', 'offsetBottom']
		options[key] = vp.height * options[key] if 0 < Math.abs(options[key]) < 1

	# Get element dimensions with offsets
	vm = el.getBoundingClientRect()

	# Test if in viewport
	vm.top + options.offsetTop <= vp.height and
	vm.bottom + options.offsetBottom >= 0 and
	vm.left <= vp.width and
	vm.right >= 0
