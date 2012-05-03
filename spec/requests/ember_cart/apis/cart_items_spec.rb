require 'spec_helper'

describe 'CartItems' do
  let(:cart) { create(:cart) }
  before do
    mock_cookies

    page.cookies[:current_cart_id] = cart.id
  end

  describe "POST /cart_items" do
    let(:product) { create(:product) }

    context "when not having children" do
      before do
        post cart_items_path, format: :json, cart_item: {
          cartable_id: product.id,
          cartable_type: product.class,
          quantity: 1,
          group: 'booking'
        }
      end

      subject { JSON.parse(response.body)["cart_item"] }

      specify { response.status.should == 201 }
      specify { subject["name"].should == product.name }
      specify { subject["price"].should == product.price.round(2).to_s }
      specify { subject["quantity"].should == 1 }
      specify { subject["group"].should == 'booking' }
    end

    context "when having children" do
      before do
        post cart_items_path, format: :json, cart_item: {
          cartable_id: product.id,
          cartable_type: product.class,
          quantity: 1,
          group: 'booking',
          children_attributes: [{
            cartable_id: product.id,
            cartable_type: product.class.name,
            name: product.name,
            price: product.price,
            quantity: 1,
            group: 'booking'
          }]
        }
      end

      subject { response.body }

      specify { response.status.should == 201 }
      it { should have_json_path "cart_item/child_ids" }
      it { should have_json_size(1).at_path("cart_item/child_ids") }
    end
  end

  describe "PUT /cart_items/{id}" do
    let(:quantity) { 2 }
    subject { JSON.parse(response.body)["cart_item"] }

    context 'when not having children' do
      let(:cart_item) { create(:cart_item) }

      before do
        put cart_item_path(cart_item), format: :json, cart_item: {
          quantity: quantity
        }
      end

      specify { response.status.should == 200 }
      specify { subject["quantity"].should == quantity }
    end

    context 'when having children' do
      let(:cart_item) { create(:cart_item_with_children, children_count: 1) }

      before do
        put cart_item_path(cart_item), format: :json, cart_item: {
          quantity: quantity,
          children_attributes: cart_item.children.map do |i|
            { id: i.id, quantity: quantity }
          end
        }
      end

      specify { response.status.should == 200 }
      specify { subject["quantity"].should == quantity }
    end
  end

  describe "DELETE /cart_items/{id}" do
    context "when a cart item exists in a cart" do
      let(:cart_item) { create(:cart_item) }

      before { delete cart_item_path(cart_item), format: :json }

      subject { response }

      its(:status) { should == 200 }
      it "removes the cart item" do
        EmberCart::CartItem.should_not be_exist(id: cart_item.id)
      end
    end
  end
end
