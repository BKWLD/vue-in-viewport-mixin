{ viewportH, boxH } = require '../support/vars'
context 'Full height story', ->

	beforeEach -> 
		cy.viewport 800, viewportH
		cy.visit 'iframe.html?id=examples--full-height'

	it 'is initially hidden', -> 
		cy.checkState 
			now:   false
			fully: false
			above: false
			below: true
	
	it 'is visible after 1px of scroll', -> 
		cy.scroll 1
		cy.checkState 
			now:   true
			fully: false
			above: false
			below: true
	
	it 'is fully visible after scrolling 100vh', -> 
		cy.scroll viewportH
		cy.checkState 
			now:   true
			fully: true
			above: false
			below: true
	
	it 'is also above after another px of scroll', -> 
		cy.scroll viewportH + 1
		cy.checkState 
			now:   true
			fully: true
			above: true
			below: true
	
	it 'continues to be fully in viewport after another 200px of scroll', -> 
		cy.scroll viewportH + boxH
		cy.checkState 
			now:   true
			fully: true
			above: true
			below: false
	
	it 'is no longer fully in viewport after another 1px of scoll', -> 
		cy.scroll viewportH + boxH + 1
		cy.checkState 
			now:   true
			fully: false
			above: true
			below: false
		