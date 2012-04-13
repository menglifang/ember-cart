EmberCart.MiniCartBar = Ember.View.extend
  tagName: 'div'
  classNames: ['ec-mini-cart-bar']

  templateName: 'ember_cart/ember/templates/carts/mini_cart_bar'

  cartsBinding: 'EmberCart.cartsController.content'
  cartItemsCountBinding: 'EmberCart.cartsController.cartItemsCount'

  mouseEnter: ->
    $('.ec-mini-cart-list').show()

  mouseLeave: ->
    $('.ec-mini-cart-list').hide()
