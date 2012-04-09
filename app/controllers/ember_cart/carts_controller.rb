module EmberCart
  class CartsController < ApplicationController
    #before_filter :load_cart, only: :destroy

    def index
      respond_to do |format|
        format.json { render_for_api :default, json: ember_carts, root: :carts, status: :ok }
      end
    end

    #def destroy
      #@cart.destroy if has_cart?

      #head :ok
    #end
  end
end
