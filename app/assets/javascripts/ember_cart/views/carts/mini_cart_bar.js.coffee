EmberCart.MiniCartBar = Ember.View.extend
  tagName: 'div'
  classNames: ['ec-mini-cart-bar']

  templateName: 'ember_cart/templates/carts/mini_cart_bar'

  cartsBinding: 'EmberCart.cartsController.content'
  cartItemsCountBinding: 'EmberCart.cartsController.cartItemsCount'

  isCartsHidden: true

  eventManager: Ember.Object.create
    mouseEnter: (evt, view) ->
      view.set('isCartsHidden', false)

    mouseLeave: (evt, view) ->
      view.set('isCartsHidden', true)
