class UpdateSwapziScoreDefaultTo0Users < ActiveRecord::Migration[7.0]
  def change
    change_column_default :users, :swapzi_score, from: nil, to: 0
  end
end
