module EmberCart
  class CartItem < ActiveRecord::Base
    belongs_to :cartable, polymorphic: true
    belongs_to :cart
    belongs_to :parent, class_name: 'EmberCart::CartItem', foreign_key: :parent_id
    has_many :children, class_name: 'EmberCart::CartItem', foreign_key: :parent_id, dependent: :destroy

    accepts_nested_attributes_for :children

    validates :cartable, presence: true, cartable: true
    validates :cart, presence: true
    validates :name, presence: true
    validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
    validates :quantity, presence: true, numericality: { greater_than: 0 }
    validates :base_quantity, presence: true, numericality: { greater_than: 0 }

    acts_as_api
    api_accessible :default do |t|
      t.add :id
      t.add :cart_id
      t.add :parent_id
      t.add :children, template: :default
      t.add :cartable_id
      t.add :cartable_type
      t.add :name
      t.add :original_price
      t.add :group
      t.add :base_quantity
      t.add :price
      t.add :quantity
    end

    default_scope order("id ASC")

    before_validation :set_base_quantity

    attr_accessible :cartable, :cartable_id, :cartable_type
    attr_accessible :cart_id, :parent_id, :children_attributes
    attr_accessible :name, :price, :base_quantity, :quantity, :group

    def total
      price * quantity
    end

    def original_price
      cartable.cartable_price
    end

    class << self
      def roots
        where(parent_id: nil)
      end

      def find_by_cartable(cartable)
        find_by_cartable_id_and_cartable_type(cartable.id, cartable.class)
      end
    end

    private
    def set_base_quantity
      self.base_quantity = quantity unless base_quantity
    end
  end
end
