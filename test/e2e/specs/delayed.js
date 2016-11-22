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
		.assert.cssClassNotPresent(first, 'visible')
		.assert.cssClassNotPresent(first, 'fully')
		.assert.cssClassNotPresent(first, 'above')
		.assert.cssClassNotPresent(first, 'below')

    // First example should be empty
    .assert.cssClassNotPresent(second, 'visible')
    .assert.cssClassNotPresent(second, 'fully')
		.assert.cssClassNotPresent(second, 'above')
    .assert.cssClassNotPresent(second, 'below')

	}, 'should not update on scroll': function (browser) { browser

		// Scroll 1px down
    .execute('scrollTo(0, 1)')

		// First example should be empty
		.assert.cssClassNotPresent(first, 'visible')
		.assert.cssClassNotPresent(first, 'fully')
		.assert.cssClassNotPresent(first, 'above')
		.assert.cssClassNotPresent(first, 'below')

    // First example should be empty
    .assert.cssClassNotPresent(second, 'visible')
    .assert.cssClassNotPresent(second, 'fully')
		.assert.cssClassNotPresent(second, 'above')
    .assert.cssClassNotPresent(second, 'below')

	}, 'after toggle active prop, should be partially visible': function (browser) { browser

		// Toggle active state
		.execute('window.App.toggleActive()')

		// First is now partially visible
    .assert.cssClassPresent(first, 'visible')
		.assert.cssClassNotPresent(first, 'fully')
		.assert.cssClassPresent(first, 'above')
		.assert.cssClassNotPresent(first, 'below')

    // And second one is partially visible
		.assert.cssClassPresent(second, 'visible')
    .assert.cssClassNotPresent(second, 'fully')
		.assert.cssClassNotPresent(second, 'above')
    .assert.cssClassPresent(second, 'below')

  }, 'now a scroll to top should update the state': function (browser) { browser

		// Scroll back up to top
		.execute('scrollTo(0, 0)')

		// The first example should be fully visible again
		.assert.cssClassPresent(first, 'visible')
		.assert.cssClassPresent(first, 'fully')
		.assert.cssClassNotPresent(first, 'above')
		.assert.cssClassNotPresent(first, 'below')

    // The second example should be hidden again
    .assert.cssClassNotPresent(second, 'visible')
    .assert.cssClassNotPresent(second, 'fully')
		.assert.cssClassNotPresent(second, 'above')
    .assert.cssClassPresent(second, 'below')

	}, 'after disabling again, it should not update on scroll': function (browser) { browser

		// Disable and scroll again
		.execute('window.App.toggleActive()')
		.execute('scrollTo(0, 1)')

		// The first example should not update
		.assert.cssClassPresent(first, 'visible')
		.assert.cssClassPresent(first, 'fully')
		.assert.cssClassNotPresent(first, 'above')
		.assert.cssClassNotPresent(first, 'below')

    // The second example should not update
    .assert.cssClassNotPresent(second, 'visible')
    .assert.cssClassNotPresent(second, 'fully')
		.assert.cssClassNotPresent(second, 'above')
    .assert.cssClassPresent(second, 'below')

		// End all tests
		.end()
	},
}
