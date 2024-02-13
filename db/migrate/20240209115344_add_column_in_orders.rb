class AddColumnInOrders < ActiveRecord::Migration[7.1]
  def change
    add_column :orders, :order_status, :string
    add_column :orders, :total_bill, :float
  end
end
