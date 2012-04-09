require 'spec_helper'

module EmberCart
  describe CartItem do
    describe 'db columns' do
      [
        :cartable_id, :cartable_type, :cart_id, :name, :price, :quantity,
        :base_quantity, :parent_id, :group
      ].each do |c|
        it { should have_db_column(c) }
      end
    end

    describe 'db indexes' do
      [ :cartable_id, :cartable_type, :cart_id, :parent_id, :name ].each do |i|
        it { should have_db_index(i) }
      end
    end

    describe 'associations' do
      it { should belong_to :cartable }
      it { should belong_to :cart }
      it { should belong_to :parent }
      it { should have_many :children }
    end

    describe 'validations' do
      it { should validate_presence_of :cartable }
      it { should validate_presence_of :cart }
      it { should validate_presence_of :name }
      it { should validate_presence_of :price }
      it { should validate_presence_of :quantity }
      it { should validate_presence_of :base_quantity }

      it { should validate_numericality_of :price }
      it { should validate_numericality_of :quantity }
      it { should validate_numericality_of :base_quantity }

      it { should_not allow_value(-1).for(:price) }
      it { should_not allow_value(-1).for(:quantity) }
      it { should_not allow_value(0).for(:quantity) }
      it { should_not allow_value(0).for(:base_quantity) }

      it { should allow_value(Product.new).for(:cartable) }
      it { should_not allow_value(Cart.new).for(:cartable) }
    end

    describe ".find_by_cartable" do
      let(:cart_item) { create(:cart_item) }

      subject { CartItem.find_by_cartable(cart_item.cartable) }

      it { should be }
    end

    describe ".as_api_response" do
      let(:cart_item) { create(:cart_item) }

      subject { cart_item.as_api_response(:default) }

      it { should have_key :id }
      it { should have_key :parent_id }
      it { should have_key :cartable_id }
      it { should have_key :cartable_type }
      it { should have_key :name }
      it { should have_key :group }
      it { should have_key :original_price }
      it { should have_key :base_quantity }
      it { should have_key :price }
      it { should have_key :quantity }
    end

    describe '#base_quantity' do
      context 'without a base quantity' do
        subject { create(:cart_item, price: 10.55, quantity: 2) }

        its(:base_quantity) { should == 2 }
      end

      context 'with a base quantity' do
        subject { create(:cart_item, price: 10.55, quantity: 2, base_quantity: 1) }

        its(:base_quantity) { should == 1 }
      end
    end

    describe "#total" do
      context 'without child' do
        subject { build(:cart_item, price: 10.55, quantity: 2) }

        its(:total) { should == 10.55 * 2 }
      end

      context 'with children' do
        before do
          @parent = create(:cart_item, name: 'parent', price: 40, quantity: 1)
          create(:cart_item, name: 'child', price: 20, quantity: 2, parent: @parent)
        end

        subject { @parent }

        its(:total) { should == 40 }
      end
    end
  end
end
