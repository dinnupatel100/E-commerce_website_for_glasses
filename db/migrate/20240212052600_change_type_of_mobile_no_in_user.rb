class ChangeTypeOfMobileNoInUser < ActiveRecord::Migration[7.1]
  def change
    change_column :users, :mobile_no, :string
  end
end
