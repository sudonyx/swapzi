class UpdateSwapCounterDefaultTo0Items < ActiveRecord::Migration[7.0]
  def change
    change_column_default :items, :swap_counter, from: nil, to: 0
  end
end
