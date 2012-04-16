EmberCart.CartItem = DS.Model.extend
  cartable_id: DS.attr('number')
  cartable_type: DS.attr('string')
  name: DS.attr('string')
  price: DS.attr('number')
  quantity: DS.attr('number')
  cart: DS.belongsTo('EmberCart.Cart')
  parent: DS.belongsTo('EmberCart.CartItem')
  children: DS.hasMany('EmberCart.CartItem', embedded: true, defaultValue: [])

  increase: ->
    @set('quantity', @get('quantity') + 1)

  createChildren: (attrs) ->
    @get('children').pushObject(EmberCart.CartItem.createRecord(attrs))

