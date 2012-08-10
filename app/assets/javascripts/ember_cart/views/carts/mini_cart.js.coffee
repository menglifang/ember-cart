EmberCart.MiniCart = Ember.View.extend
  templateName: 'ember_cart/templates/carts/mini_cart'

  tagName: 'li'
  classNames: ['ec-mini-cart']

  isCartItemsHidden: true

  toggleCartItems: ->
    @set('isCartItemsHidden', !@get('isCartItemsHidden'))
