class CreateOrdersProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :orders_products do |t|
      t.integer  :quantity
      t.float :buying_price
      t.string :order_status
      t.date :order_date
      t.references :product, null: false, foreign_key: true
      t.references :order, null: false, foreign_key: true
      
      t.timestamps
    end
  end
end
