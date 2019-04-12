context 'Full height story', ->

	beforeEach -> 
		cy.viewport 800, 800
		cy.visit '?path=/story/examples--full-height'
		cy.wait 1500 # Wait for iframe to load

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
		cy.getHeight (height) ->
			cy.scroll height
			cy.checkState 
				now:   true
				fully: true
				above: false
				below: true
	
	it 'is also above after another px of scroll', -> 
		cy.getHeight (height) ->
			cy.scroll height + 1
			cy.checkState 
				now:   true
				fully: true
				above: true
				below: true
	
	it 'continues to be fully in viewport after another 200px of scroll', -> 
		cy.getHeight (height) ->
			cy.scroll height + 200
			cy.checkState 
				now:   true
				fully: true
				above: true
				below: false
	
	it 'is no longer fully in viewport after another 1px of scoll', -> 
		cy.getHeight (height) ->
			cy.scroll height + 201
			cy.checkState 
				now:   true
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