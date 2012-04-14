module EmberCart
  class CurrentCartNotFound < StandardError; end

  module ControllerExtensions
    extend ActiveSupport::Concern

    def load_or_create_carts
      @carts ||= ember_carts
    end

    def ember_carts
      return @carts unless @carts.blank?

      shopper = defined?(current_user) ? current_user : nil
      @carts = load_carts_for(shopper)

      @carts = load_carts_from_cookies if @carts.blank?
      @carts = create_carts_for(shopper) if @carts.blank?

      save_carts_to_cookies

      @carts
    end

    def current_cart
      ember_carts.each { |c| c.current = false }

      current_cart = load_current_cart_from_cookies
      unless current_cart
        current_cart = ember_carts.first if ember_carts.size == 1
      end

      raise CurrentCartNotFound unless current_cart

      set_as_current(current_cart) and return current_cart
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
      unless cookies[:ember_carts_ids].blank?
        Cart.where(id: cookies[:ember_carts_ids])
      end
    end

    def save_carts_to_cookies
      cookies[:ember_carts_ids] = @carts.map(&:id)
    end

    def load_current_cart_from_cookies
      Cart.find_by_id(cookies[:current_cart_id])
    end

    def set_as_current(cart)
      cart.current = true
      cookies[:current_cart_id] = cart.id
    end
  end
end

ActionController::Base.send(:include, EmberCart::ControllerExtensions)
