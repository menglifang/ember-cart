EmberCart::Engine.routes.draw do
  resources :carts do
    put :clear, on: :member
  end
  resources :cart_items
end
