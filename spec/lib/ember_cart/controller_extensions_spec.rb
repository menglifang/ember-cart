require 'spec_helper'

module EmberCart
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

            before { controller.cookies[:ember_carts_ids] = [cart.id] }

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

    describe '#current_cart' do
      before { controller.stub(:ember_carts).and_return(carts) }

      context 'when only one cart exists' do
        let(:carts) { [create(:cart)] }

        it 'sets it as current' do
          controller.current_cart.should == carts.first
          controller.cookies[:current_cart_id].should == carts.first.id
        end
      end

      context 'when more than one cart exists' do

        context 'and only one is set as current' do
          let(:carts) do
            [create(:cart), create(:cart), create(:cart)]
          end

          before { controller.cookies[:current_cart_id] = carts.first.id }

          it 'returns the current cart' do
            controller.current_cart.should == carts.first
          end
        end

        context 'and no one is set as current' do
          let(:carts) do
            [create(:cart), create(:cart), create(:cart)]
          end

          it 'throws a current cart not found error' do
            expect { controller.current_cart }.to(
              raise_error(CurrentCartNotFound)
            )
          end
        end
      end
    end
  end
end
