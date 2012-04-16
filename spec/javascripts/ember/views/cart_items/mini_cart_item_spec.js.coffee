#= require spec_helper

describe 'EmberCart.MiniCartItem', ->
  application = null
  miniCartItem = null
  cartItem = null

  beforeEach ->
    Factory.store = DS.Store.create
      revision: 4
      adapter: DS.RESTAdapter.create(bulkCommit: false)
      isDefaultStore: true

    application = Ember.Application.create(rootElement: '#konacha')
    miniCartItem = EmberCart.MiniCartItem.create()

  afterEach ->
    Ember.run ->
      miniCartItem.destroy()
      application.destroy()
      Factory.store.destroy()

    cartItem = null

  describe '#toggleChildren', ->
    it 'sets isChildrenHidden to false', ->
      miniCartItem.set('isChildrenHidden', true)
      miniCartItem.toggleChildren()
      
      miniCartItem.get('isChildrenHidden').should.be.false

    it 'sets isChildrenHidden to true', ->
      miniCartItem.set('isChildrenHidden', false)
      miniCartItem.toggleChildren()

      miniCartItem.get('isChildrenHidden').should.be.true

  describe '#remove', ->
    it 'removes the cart item', ->
      mock = sinon.mock(EmberCart.cartItemsController)
      mock.expects('remove').once()

      miniCartItem.remove()
      
      mock.verify()

  describe 'when having no child', ->
    beforeEach ->
      cartItem = Factory.create('cartItem')

    it 'lists the cart items', ->
      miniCartItem.set('cartItem', cartItem)

      Ember.run -> miniCartItem.appendTo('#konacha')

      miniCartItem.$('dt').length.should.equal(1)

      miniCartItem.$('dt li.ec-cart-item-name').text().should.
        equal(cartItem.get('name'))
      miniCartItem.$('dt div.ec-cart-item-price').text().trim().should.
        equal(
          Ember.I18n.t('currency.unit') +
          cartItem.get('formattedPrice') + 'x' +
          cartItem.get('quantity')
        )
      miniCartItem.$('dt div.ec-delete').text().trim().should.
        equal(Ember.I18n.t('buttons.delete'))

    it 'calls #remove when clicking on the delete link', ->
      mock = sinon.mock(miniCartItem)
      mock.expects('remove').once()

      Ember.run -> miniCartItem.appendTo('#konacha')

      miniCartItem.$('dt div.ec-delete a').click()

      mock.verify()

  describe 'when having children', ->
    beforeEach ->
      cartItem = Factory.create('cartItemWithChildren')
      miniCartItem.set('cartItem', cartItem)

    it 'does not list the children by default', ->
      Ember.run -> miniCartItem.appendTo('#konacha')

      miniCartItem.$('dd').length.should.equal(0)

    it 'toggles the children when clicking on the name of the parent', ->
      Ember.run -> miniCartItem.appendTo('#konacha')

      miniCartItem.$('dt li.ec-cart-item-name').click()
      miniCartItem.get('isChildrenHidden').should.be.false

      miniCartItem.$('dt li.ec-cart-item-name').click()
      miniCartItem.get('isChildrenHidden').should.be.true
