module EmberCart
  module ControllerExtensions
    extend ActiveSupport::Concern

    def load_or_create_carts
      @carts ||= ember_carts
    end

    def ember_carts
      shopper = defined?(current_user) ? current_user : nil

      @carts = load_carts_for(shopper) if @carts.blank?
      @carts = load_carts_from_cookies if @carts.blank?
      @carts = create_carts_for(shopper) if @carts.blank?

      save_carts_to_cookies

      @carts
    end

    def current_cart
      Cart.find(cookies[:current_cart_id])
    end

    protected
    def create_carts_for(shopper)
      [Cart.create(name: 'Default', shopper: shopper)]
    end

    private
    def load_carts_for(shopper)
      shopper ? Cart.of(shopper) : []
    end

    def load_carts_from_cookies
      Cart.find(cookies[:ember_carts_ids]) if cookies[:ember_carts_ids]
    end

    def save_carts_to_cookies
      cookies[:ember_carts_ids] = @carts.map(&:id)
    end
  end
end

ActionController::Base.send(:include, EmberCart::ControllerExtensions)
