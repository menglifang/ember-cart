#= require spec_helper

describe 'EmberCart.MiniCart', ->
  application = null
  miniCart = null
  cart = null

  beforeEach ->
    Factory.store = DS.Store.create
      revision: 4
      adapter: DS.RESTAdapter.create(bulkCommit: false)
      isDefaultStore: true

    application = Ember.Application.create()
    miniCart = EmberCart.MiniCart.create()

    cart = Factory.create('cart')
    miniCart.set('cart', cart)

  afterEach ->
    cart = null

    Ember.run ->
      miniCart.destroy()
      application.destroy()

      Factory.store.destroy()

  describe '#toggleCartItems', ->
    it 'sets isCartItemsHidden from true to false', ->
      miniCart.set('isCartItemsHidden', true)
      miniCart.toggleCartItems()

      miniCart.get('isCartItemsHidden').should.be.false

    it 'sets isCartItemsHidden from false to true', ->
      miniCart.set('isCartItemsHidden', false)
      miniCart.toggleCartItems()

      miniCart.get('isCartItemsHidden').should.be.true

  describe 'when having cart items', ->
    beforeEach ->
      cart.addCartItem(Factory.attributeFor('cartItem', quantity: 1))

    it 'shows the cart items count', ->
      Ember.run -> miniCart.appendTo('#konacha')

      miniCart.$('div.ec-cart-name').text().trim().should.equal('%@ (1)'.fmt(cart.get('name')))

    it 'hides the cart items by default', ->
      Ember.run -> miniCart.appendTo('#konacha')

      miniCart.$('.ec-mini-cart-item-list').length.should.equal(0)

    it 'calls #toggleCartItems when clicking on the name of the cart', ->
      mock = sinon.mock(miniCart)
      mock.expects('toggleCartItems').once()

      Ember.run -> miniCart.appendTo('#konacha')

      miniCart.$('div.ec-cart-name').click()

      mock.verify()

    describe 'bottom bar', ->
      beforeEach ->
        miniCart.set('isCartItemsHidden', false)

        Ember.run -> miniCart.appendTo('#konacha')

      it 'calculates the total of the cart items', ->
        miniCart.$('.ec-bottom-bar .ec-money').text().trim().
          should.equal(Ember.I18n.t('currency.unit') + cart.get('total'))

      it 'has a checkout link', ->
        miniCart.$('.ec-bottom-bar a').text().trim().
          should.equal(Ember.I18n.t('links.checkout'))
