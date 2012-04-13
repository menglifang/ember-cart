#= require spec_helper

describe 'EmberCart.CartItem', ->
  beforeEach ->
    Factory.store = DS.Store.create
      revision: 4
      adapter: DS.RESTAdapter.create(bulkCommit: false)
      isDefaultStore: true

  afterEach -> Factory.store.destroy()

  describe '#increase', ->
    it 'increase the quantity', ->
      cartItem = Factory.create('cartItem')
      cartItem.increase()

      cartItem.get('quantity').should.equal(2)
