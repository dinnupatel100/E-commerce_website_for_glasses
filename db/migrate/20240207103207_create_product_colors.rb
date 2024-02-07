class CreateProductColors < ActiveRecord::Migration[7.1]
  def change
    create_table :product_colors do |t|
      t.string :color
      t.string :images, array: true, default: []
      t.references :product_detail, null: false, foreign_key: true
      
      t.timestamps
    end
  end
end
