class RemoveColumnInOrdersProducts < ActiveRecord::Migration[7.1]
  def change
    remove_column :orders_products , :order_status
  end
end
