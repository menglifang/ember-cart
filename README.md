# EmberCart

## Description

ember-cart a rails mountable engine which provides a cart solution for e-commerce sites. It is deeply inspired by rightnow_oms and its front side is created based on ember and ember-data.

## Installation

You just need to add ember-cart to your Gemfile

```ruby
gem 'ember-cart'
```

and run `bundle install`.

## Usage

Mount ember-cart to your rails application.

```ruby
  # config/routes.rb
  mount EmberCart::Engine => "ember_cart", as: :ember_cart
```

Install the migrations of ember-cart:

```bash
  rake ember_cart:install:migrations
  rake db:migrate
```

Now you need to load or create the default carts. To achive this, you
just need to add a before filter to your ApplicationController:

```ruby
class ApplicationController < ActionController::Base
  before_filter :load_or_create_carts
end
```

The filter `load_or_create_carts` will create a default cart named
'Default' for you. If you wanna create your owner carts by yourself, you can
override `create_carts_for(shopper)` method and create your carts in it.

`create_carts_for` must return an array of carts. The parameter
`shopper` represents the current login user.

```ruby
def create_carts_for(shopper)
  [
    Cart.create(name: 'First Cart', shopper: shopper),
    Cart.create(name: 'Second Cart', shopper: shopper)
  ]
end
```

## I18n

ember-cart supports I18n now. By default it only includes two
locales: en and zh_CN, but you can create your own locales easily.
You just need to define your translations, for example:

```javascript
  EmberCart.locales.en = { 
    'cart.total': 'Total',

    'cart_item.name': 'Name',
    'cart_item.price': 'Price',
    'cart_item.quantity': 'Quantity',
    'cart_item.total': 'Total',

    'currency.unit': '$',
    
    'buttons.check_cart': 'Check Cart',
    'buttons.delete': 'Delete',
    'buttons.clean_cart': 'Clean Up',
    'buttons.continue_to_shop': 'Continue To Shop',
    'buttons.new_order': 'Submit',

    'titles.cart': 'My Shopping Cart',

    'alerts.saving_cart': 'Cart is saving, please wait...',

    'confirmations.delete_cart_item': 'Are you sure to delete this cart items?',
    'confirmations.clean_up_cart': 'Are you sure to clean up the cart?',

    'labels.shopping_cart': 'Shopping Cart',

    'links.checkout': 'Checkout'
  };
```

## Development

ember-cart is developed with Ruby 1.9.3-p125 and Rails 3.2.3

First of all, you need to create a database config for ember-cart.
There are already some useful templates under
`spec/dummy/config/`. ember-cart use MySQL by default. If you want
to use other databases, for example PostgreSQL, you need to
modify the
Gemfile and add the adapters by yourself.

```bash
  bundle install

  bundle exec rake app:db:migrate
  bundle exec rake app:db:seed
  bundle exec rake app:db:test:prepare

  bundle exec rspec

  # Start the dummy application
  rails s
```

ember-cart set up the front side test env by
[konacha](https://github.com/jfirebaugh/konacha). konacha provides two
ways to run your js tests.

- Start up an isolated server to run the tests.

  ```bash
    bundle exec rake app:konacha:serve
  ```

  and then open your browser to visit http://localhost:3500

- Run the tests in the shell.

  ```bash
    bundle exec rake app:konacha:run
  ```

## Licence
This project rocks and uses MIT-LICENSE.
