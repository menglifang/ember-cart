Factory.define 'cartItem', class: EmberCart.CartItem, (i)->
  i.id = 1
  i.cartable_type = 'Product'
  i.cartable_id  = 1
  i.name = Faker.Lorem.words().join(' ')
  i.price = 10
  i.quantity = 1
  i.group = Faker.Lorem.words(1).join(' ')
  i.cart_id = 1

Factory.define 'cartItemWithChildren', class: EmberCart.CartItem, (i)->
  apply(i, Factory.attributeFor('cartItem', name: 'parent'))

  i.children = [Factory.attributeFor('cartItem',
    id: 2, cartable_id: 2, name: Faker.Lorem.words().join(' '), parent_id: 1)]

