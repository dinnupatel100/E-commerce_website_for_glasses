class CreateReviews < ActiveRecord::Migration[7.1]
  def change
    create_table :reviews do |t|
      t.float :rating
      t.string :review_message
      t.references :user, null: false, foreign_key: true
      t.references :product_detail, null: false, foreign_key: true
      
      t.timestamps
    end
  end
end
