require 'spec_helper'

describe "Carts" do
  describe "GET /carts" do
    context "with json request" do
      let(:format) { :json }

      context "when no cart exists" do
        before do
          get carts_path, format: format
        end

        subject { response }

        its(:status) { should == 200 }
        its(:content_type) { should == "application/json" }
        its(:body) { JSON.parse(subject)['carts'].should have(1).item }
        its(:body) { JSON.parse(subject)['carts'].first['name'].should == 'Default' }
      end

      #context "when a cart with items exists" do
        #let(:product) { build(:product) }
        #let(:cart) { create(:cart) }

        #before do
          #create(:cart_item, cart: cart)
          #page.set_rack_session(current_cart_id: cart.id)

          #visit '/ember_cart/cart.json'
        #end

        #subject { JSON.parse(page.text)["cart"] }

        #specify { subject["id"].should be }
      #end
    end
  end

  #describe 'DELETE /cart' do
    #before do
      #cart_item = FactoryGirl.create(:cart_item)
      #page.set_rack_session(current_cart_id: cart_item.cart.id)

      #page.driver.submit :delete, cart_path, format: :json
    #end

    #it 'removes the cart items' do
      #RightnowOms::CartItem.should_not be_exist
    #end

    #it 'removes the cart' do
      #RightnowOms::Cart.should_not be_exist
    #end
  #end
end
