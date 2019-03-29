(function webpackUniversalModuleDefinition(root, factory) {
	if(typeof exports === 'object' && typeof module === 'object')
		module.exports = factory(require("scrollmonitor"));
	else if(typeof define === 'function' && define.amd)
		define(["scrollmonitor"], factory);
	else if(typeof exports === 'object')
		exports["vue-in-viewport-mixin"] = factory(require("scrollmonitor"));
	else
		root["vue-in-viewport-mixin"] = factory(root["scrollmonitor"]);
})(this, function(__WEBPACK_EXTERNAL_MODULE_1__) {
return /******/ (function(modules) { // webpackBootstrap
/******/ 	// The module cache
/******/ 	var installedModules = {};

/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {

/******/ 		// Check if module is in cache
/******/ 		if(installedModules[moduleId])
/******/ 			return installedModules[moduleId].exports;

/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = installedModules[moduleId] = {
/******/ 			exports: {},
/******/ 			id: moduleId,
/******/ 			loaded: false
/******/ 		};

/******/ 		// Execute the module function
/******/ 		modules[moduleId].call(module.exports, module, module.exports, __webpack_require__);

/******/ 		// Flag the module as loaded
/******/ 		module.loaded = true;

/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}


/******/ 	// expose the modules object (__webpack_modules__)
/******/ 	__webpack_require__.m = modules;

/******/ 	// expose the module cache
/******/ 	__webpack_require__.c = installedModules;

/******/ 	// __webpack_public_path__
/******/ 	__webpack_require__.p = "";

/******/ 	// Load entry module and return exports
/******/ 	return __webpack_require__(0);
/******/ })
/************************************************************************/
/******/ ([
/* 0 */
/***/ function(module, exports, __webpack_require__) {

	var scrollMonitor;

	scrollMonitor = __webpack_require__(1);

	module.exports = {
	  props: {
	    inViewportActive: {
	      type: Boolean,
	      "default": true
	    },
	    inViewportOnce: {
	      type: Boolean,
	      "default": false
	    },
	    inViewportContainer: {
	      type: String,
	      "default": null
	    },
	    inViewportOffset: {
	      type: Number,
	      "default": 0
	    },
	    inViewportOffsetTop: {
	      type: Number,
	      "default": null
	    },
	    inViewportOffsetBottom: {
	      type: Number,
	      "default": null
	    }
	  },
	  data: function() {
	    return {
	      inViewport: {
	        now: null,
	        fully: null,
	        above: null,
	        below: null,
	        listening: false
	      }
	    };
	  },
	  computed: {
	    inViewportOffsetTopComputed: function() {
	      var ref;
	      return (ref = this.inViewportOffsetTop) != null ? ref : this.inViewportOffset;
	    },
	    inViewportOffsetBottomComputed: function() {
	      var ref;
	      return (ref = this.inViewportOffsetBottom) != null ? ref : this.inViewportOffset;
	    },
	    inViewportOffsetComputed: function() {
	      return {
	        top: this.inViewportOffsetTopComputed,
	        bottom: this.inViewportOffsetBottomComputed
	      };
	    }
	  },
	  mounted: function() {
	    return this.$nextTick(this.inViewportInit);
	  },
	  destroyed: function() {
	    return this.removeInViewportHandlers();
	  },
	  watch: {
	    inViewportActive: function(active) {
	      if (active) {
	        return this.addInViewportHandlers();
	      } else {
	        return this.removeInViewportHandlers();
	      }
	    },
	    inViewportOffsetComputed: {
	      deep: true,
	      handler: function() {
	        this.removeInViewportHandlers();
	        return this.inViewportInit();
	      }
	    }
	  },
	  methods: {
	    inViewportInit: function() {
	      if (this.inViewportActive) {
	        return this.addInViewportHandlers();
	      }
	    },
	    addInViewportHandlers: function() {
	      if (this.inViewport.listening) {
	        return;
	      }
	      this.inViewport.listening = true;
	      if (this.inViewportContainer) {
	        this.scrollMonitor = (scrollMonitor.createContainer(this.inViewportContainer)).create(this.$el, this.inViewportOffsetComputed);
	      } else {
	        this.scrollMonitor = scrollMonitor.create(this.$el, this.inViewportOffsetComputed);
	      }
	      this.scrollMonitor.on('stateChange', this.updateInViewport);
	      return this.updateInViewport();
	    },
	    removeInViewportHandlers: function() {
	      if (!this.inViewport.listening) {
	        return;
	      }
	      this.inViewport.listening = false;
	      if (this.scrollMonitor) {
	        this.scrollMonitor.destroy();
	      }
	      return delete this.scrollMonitor;
	    },
	    updateInViewport: function() {
	      this.inViewport.now = this.scrollMonitor.isInViewport;
	      this.inViewport.fully = this.scrollMonitor.isFullyInViewport;
	      this.inViewport.above = this.scrollMonitor.isAboveViewport;
	      this.inViewport.below = this.scrollMonitor.isBelowViewport;
	      if (this.inViewportOnce && this.inViewport.now) {
	        return this.removeInViewportHandlers();
	      }
	    }
	  }
	};


/***/ },
/* 1 */
/***/ function(module, exports) {

	module.exports = __WEBPACK_EXTERNAL_MODULE_1__;

/***/ }
/******/ ])
});
;