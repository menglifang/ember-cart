require 'spec_helper'

module EmberCart
  describe CartsController do
    describe 'GET index' do
      before(:each) do
        get :index, format: :json, use_route: :ember_cart
      end

      it { should respond_with :ok }
      it { should respond_with_content_type /json/ }
    end

    describe 'PUT clear' do
      let(:cart) { create(:cart_with_items) }

      before do
        put :clear, id: cart.id, format: :json, use_route: :ember_cart
      end

      it { should respond_with :ok }
      it { should respond_with_content_type /json/ }
    end
  end
end
