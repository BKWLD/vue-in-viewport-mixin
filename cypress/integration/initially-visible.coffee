{ viewportH, boxH } = require '../support/vars'
context 'Initially visible story', ->

	beforeEach -> 
		cy.viewport 800, 800
		cy.visit 'iframe.html?id=examples--initially-visible'

	it 'is initially visible', -> 
		cy.checkState 
			now:   true
			fully: true
			above: false
			below: false
	
	it 'is not fully visible after 1px of scroll', -> 
		cy.scroll 1
		cy.checkState 
			now:   true
			fully: false
			above: true
			below: false
	
	it 'is still not fully visible after 10px of scroll', -> 
		cy.scroll 10
		cy.checkState 
			now:   true
			fully: false
			above: true
			below: false
	
	it 'is hidden after scrolling the box height (200px)', -> 
		cy.scroll boxH
		cy.checkState 
			now:   false
			fully: false
			above: true
			below: false
		
# Helper to check boolean-ish values
checkState = (state) ->
	
	# Find the component iframe
	cy.get('#storybook-preview-iframe').then (iframe) ->
		$doc = iframe.contents()
		for key,val of state
			cy.wrap $doc.find "[data-cy=#{key}]"
			.should 'have.text', if val then 'Yes' else 'No'
		return