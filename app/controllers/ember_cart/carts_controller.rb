module EmberCart
  class CartsController < ApplicationController
    def index
      respond_to do |format|
        format.json { render_for_api :default, json: ember_carts, root: :carts, status: :ok }
      end
    end

    def clear
      cart = Cart.find(params[:id])
      cart.cart_items.destroy_all

      respond_to do |format|
        format.json { render_for_api :default, json: cart, root: :cart, status: :ok }
      end
    end
  end
end
