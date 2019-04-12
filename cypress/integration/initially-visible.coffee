context 'Initially visible', ->

	beforeEach -> 
		cy.viewport 800, 800
		cy.visit 'initially-visible'
		cy.wait 1500 # Wait for iframe to load

	it 'is initially visible', -> 
		cy.checkState 
			now: true
			fully: true
			above: false
			below:false
	
	it 'it is not fully visible after 1px of scroll', -> 
		cy.scroll 1
		cy.checkState 
			now: true
			fully: false
			above: true
			below:false
	
	it.only 'it is hidden after scrolling the box height (200px)', -> 
		cy.scroll 200
		cy.checkState 
			now: false
			fully: false
			above: true
			below:false
		
# Helper to check boolean-ish values
checkState = (state) ->
	
	# Find the component iframe
	cy.get('#storybook-preview-iframe').then (iframe) ->
		$doc = iframe.contents()
		for key,val of state
			cy.wrap $doc.find "[data-cy=#{key}]"
			.should 'have.text', if val then 'Yes' else 'No'
		return