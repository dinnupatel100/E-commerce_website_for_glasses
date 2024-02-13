class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :password
      t.date :dob
      t.integer :mobile_no
      t.string :address
      t.string :city
      t.integer :postal_code
      t.string :role , default: "customer", null: false

      t.timestamps
    end
  end
end
