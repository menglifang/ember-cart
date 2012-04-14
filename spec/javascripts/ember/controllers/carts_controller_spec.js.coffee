#= require spec_helper

describe 'EmberCart.cartsController', ->
  beforeEach ->
    Factory.store = DS.Store.create
      revision: 4
      adapter: DS.RESTAdapter.create(bulkCommit: false)
      isDefaultStore: true

    EmberCart.store = Factory.store

  afterEach ->
    Ember.run -> Factory.store.destroy()

  describe 'properties', ->
    describe 'countCartItems', ->
      describe 'when having a cart', ->
        it 'counts the cart items', ->
          cart = Factory.create('cart')
          cart.addCartItem(Factory.attributeFor('cartItem', quantity: 2))

          EmberCart.cartsController.get('cartItemsCount').should.equal(2)

      describe 'when having more than one carts', ->
        it 'counts the cart items in all carts', ->
          firstCart = Factory.create('cart', name: 'First')
          firstCart.addCartItem(Factory.attributeFor('cartItem',
            cartable_id: 1, quantity: 2)
          )

          secondCart = Factory.create('cart', name: 'Second')
          secondCart.addCartItem(Factory.attributeFor('cartItem',
            cartable_id: 2, quantity: 1)
          )

          EmberCart.cartsController.get('cartItemsCount').should.equal(3)
