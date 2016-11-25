// DRYing up vars w/o getting into page objects
shared = require('../shared/app');
first = shared.first;
second = shared.second;

/**
 * Test delaying the activation using the `in-viewport-active` toggle
 */
module.exports = {

  'should not have initial state': function (browser) { browser
	  .url('http://localhost:8080/delayed/')
    .waitForElementVisible('#app', 1000)

		// First example should be empty
		.assert.cssClassNotPresent(first, 'in-viewport')
		.assert.cssClassNotPresent(first, 'fully-in-viewport')
		.assert.cssClassNotPresent(first, 'above-viewport')
		.assert.cssClassNotPresent(first, 'below-viewport')

    // First example should be empty
    .assert.cssClassNotPresent(second, 'in-viewport')
    .assert.cssClassNotPresent(second, 'fully-in-viewport')
		.assert.cssClassNotPresent(second, 'above-viewport')
    .assert.cssClassNotPresent(second, 'below-viewport')

	}, 'should not update on scroll': function (browser) { browser

		// Scroll 1px down
    .execute('scrollTo(0, 1)')

		// First example should be empty
		.assert.cssClassNotPresent(first, 'in-viewport')
		.assert.cssClassNotPresent(first, 'fully-in-viewport')
		.assert.cssClassNotPresent(first, 'above-viewport')
		.assert.cssClassNotPresent(first, 'below-viewport')

    // First example should be empty
    .assert.cssClassNotPresent(second, 'in-viewport')
    .assert.cssClassNotPresent(second, 'fully-in-viewport')
		.assert.cssClassNotPresent(second, 'above-viewport')
    .assert.cssClassNotPresent(second, 'below-viewport')

	}, 'after toggle active prop, should be partially visible': function (browser) { browser

		// Toggle active state
		.execute('window.App.toggleActive()')

		// First is now partially visible
    .assert.cssClassPresent(first, 'in-viewport')
		.assert.cssClassNotPresent(first, 'fully-in-viewport')
		.assert.cssClassPresent(first, 'above-viewport')
		.assert.cssClassNotPresent(first, 'below-viewport')

    // And second one is partially visible
		.assert.cssClassPresent(second, 'in-viewport')
    .assert.cssClassNotPresent(second, 'fully-in-viewport')
		.assert.cssClassNotPresent(second, 'above-viewport')
    .assert.cssClassPresent(second, 'below-viewport')

  }, 'now a scroll to top should update the state': function (browser) { browser

		// Scroll back up to top
		.execute('scrollTo(0, 0)')

		// The first example should be fully visible again
		.assert.cssClassPresent(first, 'in-viewport')
		.assert.cssClassPresent(first, 'fully-in-viewport')
		.assert.cssClassNotPresent(first, 'above-viewport')
		.assert.cssClassNotPresent(first, 'below-viewport')

    // The second example should be hidden again
    .assert.cssClassNotPresent(second, 'in-viewport')
    .assert.cssClassNotPresent(second, 'fully-in-viewport')
		.assert.cssClassNotPresent(second, 'above-viewport')
    .assert.cssClassPresent(second, 'below-viewport')

	}, 'after disabling again, it should not update on scroll': function (browser) { browser

		// Disable and scroll again
		.execute('window.App.toggleActive()')
		.execute('scrollTo(0, 1)')

		// The first example should not update
		.assert.cssClassPresent(first, 'in-viewport')
		.assert.cssClassPresent(first, 'fully-in-viewport')
		.assert.cssClassNotPresent(first, 'above-viewport')
		.assert.cssClassNotPresent(first, 'below-viewport')

    // The second example should not update
    .assert.cssClassNotPresent(second, 'in-viewport')
    .assert.cssClassNotPresent(second, 'fully-in-viewport')
		.assert.cssClassNotPresent(second, 'above-viewport')
    .assert.cssClassPresent(second, 'below-viewport')

		// End all tests
		.end()
	},
}
