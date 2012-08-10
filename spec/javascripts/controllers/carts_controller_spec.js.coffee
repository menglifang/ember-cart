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

  describe 'instance methods', ->
    cart = null

    beforeEach -> cart = Factory.create('cart', current: true)
    
    afterEach -> cart = null

    describe '#addCartItem', ->
      it 'adds a cart item to the current cart', ->
        cartItemAttrs = Factory.attributeFor('cartItem')

        mock = sinon.mock(cart)
        mock.expects('addCartItem').withExactArgs(cartItemAttrs).once()

        EmberCart.cartsController.addCartItem(cartItemAttrs)

        mock.verify()


  describe 'properties', ->
    firstCart = null
    secondCart = null

    beforeEach ->
      firstCart = Factory.create('cart', name: 'First', current: true)
      firstCart.addCartItem(Factory.attributeFor(
        'cartItem', cartable_id: 1, quantity: 2
      ))

      secondCart = Factory.create('cart', name: 'Second')
      secondCart.addCartItem(Factory.attributeFor(
        'cartItem', cartable_id: 2, quantity: 1
      ))

    afterEach ->
      firstCart = null
      secondCart = null

    describe 'currentCart', ->
      it 'returns the current cart', ->
        EmberCart.cartsController.get('currentCart').should.equal(firstCart)

    describe 'countCartItems', ->
      it 'counts the cart items in all carts', ->
        EmberCart.cartsController.get('cartItemsCount').should.equal(3)
