class CreateEmberCartCartItems < ActiveRecord::Migration
  def change
    create_table :ember_cart_cart_items do |t|
      t.belongs_to :cartable, polymorphic: true
      t.belongs_to :cart
      t.string :name
      t.decimal :price, :precision => 10, :scale => 2
      t.integer :quantity
      t.integer :base_quantity
      t.string :group
      t.integer :parent_id

      t.timestamps
    end
    add_index :ember_cart_cart_items, :cartable_id
    add_index :ember_cart_cart_items, :cartable_type
    add_index :ember_cart_cart_items, :cart_id
    add_index :ember_cart_cart_items, :parent_id
    add_index :ember_cart_cart_items, :name
  end
end
