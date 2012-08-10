#= require spec_helper

describe 'EmberCart.cartItemsController', ->
  beforeEach ->
    Factory.store = DS.Store.create
      revision: 4
      adapter: DS.RESTAdapter.create(bulkCommit: false)
      isDefaultStore: true

  afterEach ->
    Ember.run -> Factory.store.destroy()

  describe '#remove', ->
    it 'removes the cart item from the cart', ->
      cart = Factory.create('cart')
      cartItem = cart.addCartItem(Factory.attributeFor('cartItem'))

      mock = sinon.mock(cart)
      mock.expects('removeCartItem').withExactArgs(cartItem).once()

      EmberCart.cartItemsController.remove(cartItem)

      mock.verify()
