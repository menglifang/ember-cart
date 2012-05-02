EmberCart.cartItemsController = Ember.ArrayController.create
  remove: (cartItem) ->
    cartItem.get('cart').removeCartItem(cartItem)

    EmberCart.store.commit()
