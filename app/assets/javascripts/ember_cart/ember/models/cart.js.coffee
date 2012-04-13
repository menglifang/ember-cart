EmberCart.Cart = DS.Model.extend
  name: DS.attr('string')
  cart_items: DS.hasMany('EmberCart.CartItem')

  cartItemsCount: Ember.computed( ->
    count = 0
    @get("cart_items").forEach (i) ->
      count += i.get('quantity')

    count
  ).property("cart_items.@each.quantity")

  total: Ember.computed( ->
    total = 0
    @get('cart_items').forEach (i) ->
      total += i.get('price') * i.get('quantity')

    round(total, 2)
  ).property("cart_items.@each.price", "cart_items.@each.quantity")

  addCartItem: (attrs) ->
    attrs.cart_id = @get('id')

    return @createCartItem(attrs) if attrs.mergable == false

    cartItem = @findCartItemByCartable(attrs.cartable_type, attrs.cartable_id)
    return cartItem.increase() if cartItem

    @createCartItem(attrs)

  removeCartItem: (cartItem) ->
    @get('cart_items').removeObject(cartItem)
    cartItem.deleteRecord()

  # @private
  createCartItem: (attrs) ->
    cartItem = EmberCart.CartItem.createRecord(attrs)
    @get('cart_items').pushObject(cartItem)

  # @private
  findCartItemByCartable: (type, id) ->
    @get('cart_items').filter((i) ->
      return true if i.get('cartable_type') == type && i.get('cartable_id') == id
    ).get('firstObject')
