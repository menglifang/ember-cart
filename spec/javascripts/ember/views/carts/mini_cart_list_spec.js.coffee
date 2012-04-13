#= require spec_helper

describe 'EmberCart.MiniCartList', ->
  application = null
  miniCartList = null

  beforeEach ->
    Factory.store = DS.Store.create
      revision: 4
      adapter: DS.RESTAdapter.create(bulkCommit: false)
      isDefaultStore: true

    application = Ember.Application.create()
    miniCartList = EmberCart.MiniCartList.create()

  afterEach ->
    Ember.run ->
      miniCartList.destroy()
      application.destroy()
      
      Factory.store.destroy

  it 'lists the carts', ->
    miniCartList.set('carts', [
      Factory.create('cart', name: 'First'),
      Factory.create('cart', name: 'Second')
    ])

    Ember.run ->
      miniCartList.appendTo('#konacha')

    miniCartList.$('li').length.should.equal(2)
