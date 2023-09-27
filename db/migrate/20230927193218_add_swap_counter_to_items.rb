class AddSwapCounterToItems < ActiveRecord::Migration[7.0]
  def change
    add_column :items, :swap_counter, :integer
  end
end
