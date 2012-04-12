Factory.define 'cart', class: EmberCart.Cart, (c)->
  c.name = Faker.Lorem.words().join(' ')
