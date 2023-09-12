class CreateSwaps < ActiveRecord::Migration[7.0]
  def change
    create_table :swaps do |t|
      t.date :date_initiated
      t.date :date_completed
      t.boolean :accepted_user_1
      t.boolean :accepted_user_2
      t.boolean :completed_user_1
      t.boolean :completed_user_2
      t.boolean :completed
      t.references :user_1, null: false, foreign_key: { to_table: 'users' }
      t.references :user_2, null: false, foreign_key: { to_table: 'users' }
      t.references :item_1, null: false, foreign_key: { to_table: 'items' }
      t.references :item_2, null: false, foreign_key: { to_table: 'items' }

      t.timestamps
    end
  end
end
