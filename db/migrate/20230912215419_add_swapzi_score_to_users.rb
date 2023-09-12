class AddSwapziScoreToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :swapzi_score, :integer
  end
end
