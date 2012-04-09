require 'spec_helper'

module EmberCart
  describe Cart do
    describe 'db columns' do
      it { should have_db_column :name }
    end

    describe 'validations' do
      it { should validate_presence_of :name }
    end

    describe '#cartable_count' do
      let(:cart) { create(:cart) }
      subject { cart }

      context 'no child items' do
        before do
          create(:cart_item, name: 'first', quantity: 1, cart: cart)
          create(:cart_item, name: 'second', quantity: 2, cart: cart)
        end

        its(:cartable_count) { should == 3 }
      end

      context 'having child items' do
        before do
          create(:cart_item, name: 'first', quantity: 1, cart: cart)
          parent = create(:cart_item, name: 'second-parent', quantity: 2, cart: cart)
          create(:cart_item, name: 'second-child', quantity: 2, parent: parent, cart: cart)
        end

        its(:cartable_count) { should == 3 }
      end
    end

    describe '#total' do
      let(:cart) { build(:cart) }
      subject { cart }

      context 'with no items' do
        its(:total) { should == 0 }
      end

      context 'with items' do
        context 'and no child' do
          before { create(:cart_item, cart: cart) }

          its(:total) { should == cart.cart_items.first.total }
        end

        context 'and having children' do
          before do
            parent = create(:cart_item, name: 'parent', price: 2.0, cart: cart)
            create(:cart_item, name: 'child', price: 2.0,
                   parent: parent, cart: cart)
          end

          its(:total) { should == 2 }
        end
      end
    end

    describe "#add_item" do
      let(:cart) { create(:cart) }
      let(:product) { create(:product, price: 10) }
      subject { cart }

      context 'when the item does not exist' do
        before { cart.add_item(product) }

        its(:total) { should == product.price }
        its(:cart_items) { should have(1).item }

        specify { cart.cart_items.first.cartable.should == product }
        specify { cart.cart_items.first.name.should == product.name }
        specify { cart.cart_items.first.price.should == product.price }
        specify { cart.cart_items.first.quantity.should == 1 }
        specify { cart.cart_items.first.total.should == product.price * 1 }
      end

      context 'when the item exists' do
        before { cart.add_item(product) }

        context 'and adding a same item not setting to unmergable' do
          before { cart.add_item(product) }

          its(:total) { should == product.price * 2 }
          its(:cart_items) { should have(1).item }

          specify { cart.cart_items.first.cartable.should == product }
          specify { cart.cart_items.first.name.should == product.name }
          specify { cart.cart_items.first.price.should == product.price }
          specify { cart.cart_items.first.quantity.should == 2 }
          specify { cart.cart_items.first.total.should == product.price * 2 }
        end

        context 'and adding a same item setting to unmergable' do
          before { cart.add_item(product, mergable: false) }

          its(:cart_items) { should have(2).items }
        end
      end

      context 'when adding two different items' do
        let(:another_product) { create(:product, name: 'another product for test', price: 10) }

        before do
          cart.add_item(product)
          cart.add_item(another_product)
        end

        its(:total) { should == product.price + another_product.price }
        its(:cart_items) { should have(2).items }
      end
    end
  end
end
