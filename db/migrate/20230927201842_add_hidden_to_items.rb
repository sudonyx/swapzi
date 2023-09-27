class AddHiddenToItems < ActiveRecord::Migration[7.0]
  def change
    add_column :items, :hidden, :boolean, default: false
  end
end
