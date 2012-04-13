EmberCart.MiniCartItem = Ember.View.extend
  templateName: 'ember_cart/ember/templates/cart_items/mini_cart_item'

  tagName: 'dl'
  classNames: ['ec-mini-cart-item']

  isChildrenHidden: true

  toggleChildren: ->
    hidden = @get('isChildrenHidden')
    @set('isChildrenHidden', !hidden)

  remove: ->
    cartItem = @get('cartItem')
    EmberCart.cartItemsController.remove(cartItem)
