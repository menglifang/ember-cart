EmberCart.cartsController = Ember.ArrayController.create
  content: Ember.computed( ->
    EmberCart.store.findAll(EmberCart.Cart)
  ).property()
