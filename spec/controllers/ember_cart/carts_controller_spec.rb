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

    #describe 'DELETE destroy' do
      #let(:cart) { FactoryGirl.create(:cart) }

      #before do
        #Cart.should_receive(:find_by_id).and_return(cart)
        #cart.should_receive(:destroy)

        #delete :destroy, format: :json, use_route: :rightnow_oms
      #end

      #it { should respond_with :ok }
      #it { should respond_with_content_type /json/ }
    #end
  end
end
