require 'spec_helper'

module EmberCart
  describe CartItemsController do
    let(:product) { build(:product) }

    describe "POST create" do
      let(:cart) { build(:cart) }
      let(:cart_item) { build(:cart_item, cart: cart) }

      before do
        controller.should_receive(:current_cart).and_return(cart)
        controller.should_receive(:find_cartable).and_return(product)
        cart.should_receive(:add_item).and_return(cart_item)
      end

      context "with valid params" do
        before do
          cart_item.should_receive(:valid?).and_return(true)
          post :create, format: :json, use_route: :ember_cart, cart_item: {}
        end

        it { should respond_with :created }
        it { should respond_with_content_type /json/ }
      end

      context "with invalid params" do
        before do
          cart_item.should_receive(:valid?).and_return(false)
          post :create, format: :json, use_route: :ember_cart, cart_item: {}
        end

        it { should respond_with :unprocessable_entity }
      end
    end

    describe 'PUT update' do
      let(:cart_item) { build(:cart_item) }
      before { CartItem.should_receive(:find).and_return(cart_item) }

      context 'with valid params' do
        before do
          cart_item.should_receive(:update_attributes).and_return(true)

          put :update, format: :json, use_route: :ember_cart
        end

        it { should respond_with :ok }
        it { should respond_with_content_type /json/ }
      end

      context 'with invalid params' do
        before do
          cart_item.should_receive(:update_attributes).and_return(false)

          put :update, format: :json, use_route: :ember_cart
        end

        it { should respond_with :unprocessable_entity }
        it { should respond_with_content_type /json/ }
      end
    end

    describe 'DELETE destroy' do
      let(:cart_item) { build(:cart_item) }

      before do
        CartItem.should_receive(:find).and_return(cart_item)
        cart_item.should_receive(:destroy)

        delete :destroy, format: :json, use_route: :ember_cart
      end

      it { should respond_with :ok }
    end
  end
end
