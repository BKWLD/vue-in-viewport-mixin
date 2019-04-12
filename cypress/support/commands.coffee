# Check the state of the Box component
Cypress.Commands.add 'checkState', (state) ->
	for key,val of state
		cy.get "[data-cy=#{key}]"
		.should 'have.text', if val then 'Yes' else 'No'
	return

# Scroll the storybook ifrmae
Cypress.Commands.add 'scroll', (y) ->
	cy.get('.viewport').scrollTo(0,y)
