class CreateEmberCartCarts < ActiveRecord::Migration
  def change
    create_table :ember_cart_carts do |t|
      t.string :name
      t.belongs_to :shopper, polymorphic: true

      t.timestamps
    end
    add_index :ember_cart_carts, :shopper_id
    add_index :ember_cart_carts, :shopper_type
  end
end
