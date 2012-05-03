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
        its(:body) { should have_json_size(1).at_path("carts") }
      end
    end
  end

  describe 'PUT /carts/{id}/clear' do
    let(:cart) { create(:cart_with_items) }

    before do
      put clear_cart_path(cart), format: :json
    end

    subject { response }

    its(:status) { should == 200 }
    its(:body) { should have_json_size(0).at_path("cart/cart_item_ids") }
  end
end
