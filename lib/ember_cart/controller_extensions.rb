module EmberCart
  module ControllerExtensions
    extend ActiveSupport::Concern

    def ember_carts
      shopper = defined?(current_user) ? current_user : nil

      @_carts = Cart.of(shopper) if @_carts.blank?
      @_carts = default_carts_of(shopper) if @_carts.blank?

      @_carts
    end

    protected
    def default_carts_of(shopper)
      [Cart.create(name: 'Default', shopper: shopper)]
    end
  end
end

ActionController::Base.send(:include, EmberCart::ControllerExtensions)
