EmberCart.cartsController = Ember.ArrayController.create
  content: Ember.computed( ->
    EmberCart.store.findAll(EmberCart.Cart)
  ).property()

  cartItemsCount: Ember.computed( ->
    count = 0
    @get('content').forEach (i) ->
      count += i.get('cartItemsCount')

    count
  ).property('content.@each.cartItemsCount')
