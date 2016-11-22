module.exports = {

  'should have initial state': function (browser) { browser
	  .url('http://localhost:8080/once/')
    .waitForElementVisible('#app', 1000)

		// The first example should be visible initialy
		.assert.cssClassPresent('.example:nth-child(1)', 'visible')
		.assert.cssClassPresent('.example:nth-child(1)', 'fully')
		.assert.cssClassNotPresent('.example:nth-child(1)', 'above')
		.assert.cssClassNotPresent('.example:nth-child(1)', 'below')

    // The second example should be hidden
    .assert.cssClassNotPresent('.example:nth-child(2)', 'visible')
    .assert.cssClassNotPresent('.example:nth-child(2)', 'fully')
		.assert.cssClassNotPresent('.example:nth-child(2)', 'above')
    .assert.cssClassPresent('.example:nth-child(2)', 'below')

	}, 'should no longer be fully visible after 1px of scroll': function (browser) { browser

		// Scroll 1px down
    .execute('scrollTo(0, 1)')

    // First is now partially visible
    .assert.cssClassPresent('.example:nth-child(1)', 'visible')
		.assert.cssClassNotPresent('.example:nth-child(1)', 'fully')
		.assert.cssClassPresent('.example:nth-child(1)', 'above')
		.assert.cssClassNotPresent('.example:nth-child(1)', 'below')

    // And second one is partially visible
		.assert.cssClassPresent('.example:nth-child(2)', 'visible')
    .assert.cssClassNotPresent('.example:nth-child(2)', 'fully')
		.assert.cssClassNotPresent('.example:nth-child(2)', 'above')
    .assert.cssClassPresent('.example:nth-child(2)', 'below')

	}, 'should not update again if scrolling back to top': function (browser) { browser

		// Scroll back to top
		.execute('scrollTo(0, 0)')

		// All of the settings from the previous step
    .assert.cssClassPresent('.example:nth-child(1)', 'visible')
		.assert.cssClassNotPresent('.example:nth-child(1)', 'fully')
		.assert.cssClassPresent('.example:nth-child(1)', 'above')
		.assert.cssClassNotPresent('.example:nth-child(1)', 'below')

		// All of the settings from the previous step
		.assert.cssClassPresent('.example:nth-child(2)', 'visible')
    .assert.cssClassNotPresent('.example:nth-child(2)', 'fully')
		.assert.cssClassNotPresent('.example:nth-child(2)', 'above')
    .assert.cssClassPresent('.example:nth-child(2)', 'below')

		// All tests done
		.end();
  },
}
