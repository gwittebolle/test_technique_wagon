class AddDefaultBestScoreToUsers < ActiveRecord::Migration[7.1]
  def change
    change_column_default :users, :best_score, 0
  end
end
