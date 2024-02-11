class RemoveColumnInOrders < ActiveRecord::Migration[7.1]
  def change
    remove_column :orders, :payment_mode
    remove_column :orders, :payment_status
    remove_column :orders, :transaction_id
    
  end
end
