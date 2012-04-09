class CreateEmberCartCarts < ActiveRecord::Migration
  def change
    create_table :ember_cart_carts do |t|
      t.string :name

      t.timestamps
    end
  end
end
