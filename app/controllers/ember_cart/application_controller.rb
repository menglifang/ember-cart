module EmberCart
  class ApplicationController < ActionController::Base
    before_filter :load_or_create_carts
  end
end
