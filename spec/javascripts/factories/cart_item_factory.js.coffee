Factory.define 'cartItem', class: EmberCart.CartItem, (i)->
  i.cartable_type = 'Product'
  i.cartable_id  = 1
  i.name = 'A product'
  i.price = 10
  i.quantity = 1
  i.group = 'instant'
  i.cart_id = 1

Factory.define 'cartItemWithChildren', class: EmberCart.CartItem, (i)->
  apply(i, Factory.attributeFor('cartItem', name: 'parent'))

  i.children = [Factory.attributeFor('cartItem', cartable_id: 2, name: 'child')]

