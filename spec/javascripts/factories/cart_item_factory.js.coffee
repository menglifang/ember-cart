Factory.define 'cartItem', class: EmberCart.CartItem, (i)->
  i.id = 1
  i.cartable_type = 'Product'
  i.cartable_id  = 1
  i.name = Faker.Lorem.words().join(' ')
  i.price = 10
  i.quantity = 1
  i.group = Faker.Lorem.words(1).join(' ')

Factory.define 'cartItemWithChildren', class: EmberCart.CartItem, (i)->
  apply(i,
    Factory.attributeFor('cartItem', name: Faker.Lorem.words().join(' '))
  )

  childId = 2
  childCartableId = 2

  i.children = []
  i.children.push(Factory.attributeFor('cartItem',
    cartable_id: childCartableId++,
    name: Faker.Lorem.words().join(' ')
  )) for t in [0..2]
