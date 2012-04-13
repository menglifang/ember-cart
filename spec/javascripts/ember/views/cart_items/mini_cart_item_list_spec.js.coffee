#= require spec_helper

describe 'EmberCart.MiniCartItemList', ->
  application = null
  miniCartItemList = null

  beforeEach ->
    Factory.store = DS.Store.create
      revision: 4
      adapter: DS.RESTAdapter.create(bulkCommit: false)
      isDefaultStore: true

    application = Ember.Application.create(rootElement: '#konacha')
    miniCartItemList = EmberCart.MiniCartItemList.create()

  afterEach ->
    Ember.run ->
      miniCartItemList.destroy()
      application.destroy()
      Factory.store.destroy()

  it 'lists the cart items', ->
    cartItems = [
      Factory.create('cartItem', cartable_id: 1),
      Factory.create('cartItem', cartable_id: 2)
    ]

    miniCartItemList.set('cartItems', cartItems)

    Ember.run -> miniCartItemList.appendTo('#konacha')

    miniCartItemList.$('dt').length.should.equal(2)
