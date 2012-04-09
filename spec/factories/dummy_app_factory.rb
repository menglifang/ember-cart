FactoryGirl.define do
  factory :product, class: Product do
    name Faker::Product.product_name
    price { rand(100) }
  end
end
