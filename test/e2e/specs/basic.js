module.exports = {
  'basic': function (browser) {
    browser
  	  .url('http://localhost:8080/basic/')
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

      // Scroll 1px
      .execute('scrollTo(0,1)')

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

			// Scroll a whole page height
			.execute('scrollTo(0,window.innerHeight)')

			// First is now hidden
      .assert.cssClassNotPresent('.example:nth-child(1)', 'visible')
			.assert.cssClassNotPresent('.example:nth-child(1)', 'fully')
			.assert.cssClassPresent('.example:nth-child(1)', 'above')
			.assert.cssClassNotPresent('.example:nth-child(1)', 'below')

      // And second one is fully visible
			.assert.cssClassPresent('.example:nth-child(2)', 'visible')
      .assert.cssClassPresent('.example:nth-child(2)', 'fully')
			.assert.cssClassNotPresent('.example:nth-child(2)', 'above')
      .assert.cssClassNotPresent('.example:nth-child(2)', 'below')

			.end();
  }
}
