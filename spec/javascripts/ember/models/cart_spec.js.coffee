#= require spec_helper

describe "EmberCart.Cart", ->
  cart = null

  beforeEach ->
    Factory.store = DS.Store.create
      revision: 4
      adapter: DS.RESTAdapter.create(bulkCommit: false)
      isDefaultStore: true

    cart = Factory.create('cart')

  afterEach ->
    cart = null

    Ember.run -> Factory.store.destroy()

  describe 'instance methods', ->
    describe '#findCartItemByCartable', ->
      it 'finds out the cart item', ->
        cartItem = Factory.create('cartItem', cart_id: cart.get('id'))
        cart.get('cart_items').pushObject(cartItem)

        cart.findCartItemByCartable('Product', 1).should.equal(cartItem)

    describe '#addCartItem', ->
      cartItem = null

      afterEach ->
        cartItem = null

      describe 'when the item does not exist', ->
        beforeEach ->
          cartItem = cart.addCartItem(Factory.attributeFor('cartItem'))

        it 'creates an item', ->
          cart.getPath('cart_items.length').should.equal(1)

        it 'sets the cart to the item', ->
          cartItem.get('cart').should.equal(cart)

      describe 'when the item exists', ->
        beforeEach ->
          cart.addCartItem(Factory.attributeFor('cartItem'))

        describe 'and it can be merged', ->
          describe 'since mergable is not set', ->
            beforeEach ->
              cartItem = cart.addCartItem(Factory.attributeFor('cartItem'))

            it 'merges the item', ->
              cart.getPath('cart_items.length').should.equal(1)

            it 'increases the quantity of the item', ->
              cartItem.get('quantity').should.equal(2)

          describe 'since mergable is set to true', ->
            beforeEach ->
              cartItem = cart.addCartItem(Factory.attributeFor('cartItem',
                mergable: true))

            it 'merges the item', ->
              cart.getPath('cart_items.length').should.equal(1)

            it 'increases the quantity of the item', ->
              cartItem.get('quantity').should.equal(2)

        describe 'and it can not be merged', ->
          it 'creates a new item', ->
            cart.addCartItem(Factory.attributeFor('cartItem', mergable: false))

            cart.getPath('cart_items.length').should.equal(2)

    describe '#removeCartItem', ->
      cartItem = null

      beforeEach ->
        cartItem = cart.addCartItem(Factory.attributeFor('cartItem'))

      afterEach ->
        cartItem = null

      it 'removes the cart item from the cart and deletes it', ->
        mock = sinon.mock(cartItem)
        mock.expects('deleteRecord').once()

        cart.removeCartItem(cartItem)

        cart.getPath('cart_items.length').should.equal(0)
        mock.verify()

    describe '#increaseCartItem', ->

    describe '#decreaseCartItem', ->

    describe '#cleanUp', ->

  describe 'properties', ->
    beforeEach ->
      cart.addCartItem(Factory.attributeFor('cartItem',
        cartable_id: 1, price: 10, quantity: 1))
      cart.addCartItem(Factory.attributeFor('cartItem',
        cartable_id: 2, price: 15, quantity: 2))

    describe 'cartItemsCount', ->
      it 'counts the items', ->
        cart.get('cartItemsCount').should.equal(3)

    describe 'total', ->
      it 'calculates the total of the cart items', ->
        cart.get('total').should.equal("40.00")
