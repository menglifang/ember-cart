module EmberCart
  class CartItemsController < ApplicationController
    before_filter :load_cart_item, only: [:update, :destroy]

    # TODO Unit test needed
    def index
      render_for_api :default,
        json: current_cart.cart_items, root: :cart_items, status: :ok
    end

    def create
      params[:cart_item][:quantity] = 1 if params[:cart_item][:quantity].blank?
      cart_item = current_cart.add_item(find_cartable, params[:cart_item])

      respond_to do |format|
        if cart_item.valid?
          format.json do
            render_for_api :default,
              json: cart_item, root: :cart_item, status: :created
          end
        else
          format.json do
            render json: cart_item.errors, status: :unprocessable_entity
          end
        end
      end
    end

    def update
      if params[:cart_item]
        params[:cart_item].delete(:original_price)
        params[:cart_item].delete(:base_quantity)
        params[:cart_item].delete(:cart_id)
      end

      respond_to do |format|
        if @cart_item.update_attributes(params[:cart_item])
          format.json { render_for_api :default, json: @cart_item, root: :cart_item, status: :ok }
        else
          format.json { render json: @cart_item.errors, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      @cart_item.destroy

      respond_to do |format|
        format.json { render json: nil, status: :ok }
      end
    end

    private
    def find_cartable
      cartable_id = params[:cart_item][:cartable_id]
      cartable_type = params[:cart_item][:cartable_type]

      cartable_type.constantize.find_by_id(cartable_id)
    end

    def load_cart_item
      @cart_item = CartItem.find(params[:id])
    end
  end
end
