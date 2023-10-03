class AddFeaturedToItems < ActiveRecord::Migration[7.0]
  def change
    add_column :items, :featured, :boolean, default: false
  end
end
