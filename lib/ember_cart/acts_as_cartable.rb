module EmberCart
  module ActsAsCartable
    def acts_as_cartable?
      false
    end

    def acts_as_cartable(opts = { name: :name, price: :price })
      cartable_config.update(opts) if opts.is_a? Hash

      class_eval do
        include ActsAsCartable::InstanceMethods
        extend  ActsAsCartable::ClassMethods
      end
    end

    def cartable_config
      @cartable_config ||= { name: :name, price: :price }
    end

    module ClassMethods
      def acts_as_cartable?
        self.included_modules.include?(InstanceMethods)
      end
    end

    module InstanceMethods
      def cartable_name
        self.send(self.class.cartable_config[:name])
      end

      def cartable_price
        self.send(self.class.cartable_config[:price])
      end
    end
  end
end
