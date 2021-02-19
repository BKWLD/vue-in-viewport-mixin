{ viewportH, boxH } = require '../support/vars'
context 'Hidden parent story', ->

	it 'does not error', ->
		cy.visit 'iframe.html?id=testing--hidden-parent'
		cy.get '[data-cy=now]'
		cy.wait 1000
		cy.get('#error-stack').should('be.empty')
