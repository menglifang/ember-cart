EmberCart.MiniCartBar = Ember.View.extend
  tagName: 'div'
  classNames: ['ec-mini-cart-bar']

  templateName: 'ember_cart/templates/carts/mini_cart_bar'

  cartsBinding: 'EmberCart.cartsController.content'
  cartItemsCountBinding: 'EmberCart.cartsController.cartItemsCount'

  isCartsHidden: true

  eventManager: Ember.Object.create
    mouseEnter: ->
      @set('isCartsHidden', false)

    mouseLeave: ->
      @set('isCartsHidden', true)
