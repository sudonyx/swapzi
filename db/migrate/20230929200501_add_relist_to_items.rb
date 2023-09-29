class AddRelistToItems < ActiveRecord::Migration[7.0]
  def change
    add_column :items, :relist, :boolean, default: false
  end
end
