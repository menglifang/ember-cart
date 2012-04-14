require 'spec_helper'

describe EmberCart::ControllerExtensions do
  let(:controller_class) { Class.new }
  let(:controller) { controller_class.new }

  before do
    controller.stub(:cookies).and_return({})
    controller_class.send(:include, EmberCart::ControllerExtensions)
  end

  describe '#ember_carts' do
    let(:carts) { controller.ember_carts }

    context 'when having no cart' do
      context 'and no user is login' do
        context 'and no cart is saved in cookies' do
          it 'creates a default cart' do
            carts.should have(1).item
            carts.first.name.should == 'Default'
          end
        end

        context 'and a cart is saved in cookies' do
          let(:cart) { create(:cart, name: 'in cookies') }

          before { controller.cookies[:ember_carts_ids] = cart }

          it 'loads the cart from cookies' do
            carts.should have(1).item
            carts.first.should == cart
          end
        end

        context 'and more than one cart is saved in cookies' do
          before do
            controller.cookies[:ember_carts_ids] = [
              create(:cart, name: 'first in cookies').id,
              create(:cart, name: 'second in cookies').id
            ]
          end

          it 'loads the carts from cookies' do
            carts.should have(2).item
          end
        end
      end
    end
  end
end
