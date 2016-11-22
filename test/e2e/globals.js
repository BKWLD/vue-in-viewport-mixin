// Deps
const sauce = require('./sauce');

/**
 * Hooks added to all tests
 */
module.exports = {

	// Update status in sauce
	after: function(browser) {
		sauce();
	}
}
