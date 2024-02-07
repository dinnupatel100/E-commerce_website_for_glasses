class CreateProductDetails < ActiveRecord::Migration[7.1]
  def change
    create_table :product_details do |t|
      t.string :product_name
      t.string :product_description
      t.float :cost_price
      t.float :selling_price
      t.string :brand
      t.references :category, null: false, foreign_key: true
      t.timestamps
    end
  end
end
