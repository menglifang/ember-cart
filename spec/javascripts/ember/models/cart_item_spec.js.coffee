#= require spec_helper

describe 'EmberCart.CartItem', ->
  beforeEach ->
    Factory.store = DS.Store.create
      revision: 4
      adapter: DS.RESTAdapter.create(bulkCommit: false)
      isDefaultStore: true

  afterEach ->
    Ember.run -> Factory.store.destroy()

  describe '#increase', ->
    describe 'when having no children', ->
      it 'increase the quantity', ->
        cartItem = Factory.create('cartItem')
        cartItem.increase()

        cartItem.get('quantity').should.equal(2)

    describe 'when having children', ->
      it 'increases the quantities of both parent and children', ->
        parent = Factory.create('cartItem', cartable_id: 1, quantity: 1)
        parent.get('children').pushObject(Factory.create('cartItem',
          cartable_id: 2, quantity: 1))
        
        parent.increase()

        parent.get('quantity').should.equal(2)
        parent.getPath('children.firstObject.quantity').should.equal(2)

  describe '#createChildren', ->
    it 'creates a child', ->
      cartItem = Factory.create('cartItem')
      cartItem.createChildren(Factory.attributeFor('cartItem', cartable_id: 2))

      cartItem.getPath('children.length').should.equal(1)
