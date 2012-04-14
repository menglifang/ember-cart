#= require spec_helper

describe 'EmberCart.MiniCartBar', ->
  application = null
  miniCartBar = null

  beforeEach ->
    Factory.store = DS.Store.create
      revision: 4
      adapter: DS.RESTAdapter.create(bulkCommit: false)
      isDefaultStore: true

    application = Ember.Application.create('#konacha')
    miniCartBar = EmberCart.MiniCartBar.create()

  afterEach ->
    Ember.run ->
      miniCartBar.destroy()
      application.destroy()

      Factory.store.destroy()

  it 'counts the cart items', ->
    miniCartBar.set('cartItemsCount', 1)

    Ember.run -> miniCartBar.appendTo('#konacha')
    
    miniCartBar.$().text().trim().should.equal(
      Ember.I18n.t('labels.shopping_cart') + ' (1)'
    )

  it 'hides carts by default', ->
    miniCartBar.set('carts', [Factory.create('cart')])

    Ember.run -> miniCartBar.appendTo('#konacha')

    miniCartBar.$('.ec-mini-cart-list').length.should.equal(0)
