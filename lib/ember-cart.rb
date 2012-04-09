require 'acts_as_api'

require 'ember_cart/engine'
require 'ember_cart/cartable_validator'
require 'ember_cart/acts_as_cartable'

module EmberCart
end

ActiveRecord::Base.extend(EmberCart::ActsAsCartable)
