$win = $ window

module.exports =

	isInViewport: ($el, options) ->
		options = {} if !options?
		options.offsetTop = 0 if !options.offsetTop?
		options.offsetBottom = 0 if !options.offsetBottom?

		vpWidth   			= $win.width()
		vpHeight  			= $win.height()
		viewTop         = $win.scrollTop()
		viewBottom      = viewTop + vpHeight
		viewLeft        = $win.scrollLeft()
		viewRight       = viewLeft + vpWidth
		offset          = $el.offset()
		_top            = (offset.top )
		_bottom         = _top + $el.height()
		_left           = offset.left
		_right          = _left + $el.width()
		compareTop      = (_bottom + options.offsetBottom)
		compareBottom   = (_top + options.offsetTop)
		compareLeft     = _right
		compareRight    = _left

		return ((compareBottom <= viewBottom) and (compareTop >= viewTop)) and ((compareRight <= viewRight) and (compareLeft >= viewLeft))
