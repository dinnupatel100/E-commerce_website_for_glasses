class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products do |t|
      t.string :size
      t.integer :quantity
      t.references :product_color, null: false, foreign_key: true
      
      t.timestamps
    end
  end
end
