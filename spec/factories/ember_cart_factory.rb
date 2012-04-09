module EmberCart
  FactoryGirl.define do
    factory :cart, class: Cart do
      name 'Default'
    end

    factory :cart_with_items, parent: :cart do
      ignore do
        items_count 5
      end

      after_build do |c, e|
        FactoryGirl.build_list(:cart_item, e.items_count, cart: c)
      end
    end

    factory :cart_item, class: CartItem do
      association :cart, factory: :cart
      association :cartable, factory: :product

      name { cartable.name }
      price { cartable.price }
      quantity 1
    end
  end
end
