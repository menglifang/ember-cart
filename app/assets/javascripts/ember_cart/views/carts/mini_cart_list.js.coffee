EmberCart.MiniCartList = Ember.View.extend
  templateName: 'ember_cart/templates/carts/mini_cart_list'

  tagName: 'ul'
  classNames: ['ec-mini-cart-list']

  cartsBinding: 'EmberCart.cartsController.content'
