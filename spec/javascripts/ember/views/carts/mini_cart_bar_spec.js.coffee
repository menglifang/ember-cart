#= require spec_helper

describe 'EmberCart.MiniCartBar', ->
  application = null
  miniCartBar = null

  beforeEach ->
    application = Ember.Application.create('#konacha')
    miniCartBar = EmberCart.MiniCartBar.create()

  afterEach ->
    Ember.run ->
      miniCartBar.destroy()
      application.destroy()

  it 'counts the cart items', ->
    miniCartBar.set('cartItemsCount', 1)

    Ember.run -> miniCartBar.appendTo('#konacha')
    
    miniCartBar.$().text().trim().should.equal(
      Ember.I18n.t('labels.shopping_cart') + ' (1)'
    )
