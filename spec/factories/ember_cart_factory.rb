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

    factory :cart_item_with_children, parent: :cart_item do
      ignore do
        children_count 5
      end

      after_build do |ci, e|
        ci.children = FactoryGirl.build_list(:cart_item, e.children_count, parent: ci)
      end
    end
  end
end
