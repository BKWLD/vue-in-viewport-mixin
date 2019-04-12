# Check the state of the Box component
Cypress.Commands.add 'checkState', (state) ->
	cy.get('#storybook-preview-iframe').then (iframe) ->
		$doc = iframe.contents()
		for key,val of state
			cy.wrap $doc.find "[data-cy=#{key}]"
			.should 'have.text', if val then 'Yes' else 'No'
		return

# Scroll the storybook ifrmae
Cypress.Commands.add 'scroll', (y) ->
	cy.get('#storybook-preview-iframe').then (iframe) ->
		iframe.get(0).contentWindow.postMessage 
			event: 'scroll'
			amount: y
		, '*'

# Get the height of the preview iframe
Cypress.Commands.add 'getHeight', (callback) ->
	cy.get('#storybook-preview-iframe').then (iframe) ->
		height = iframe.height()
		cy.log "100vh == #{height}px"
		callback height