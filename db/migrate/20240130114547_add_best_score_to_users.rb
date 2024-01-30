class AddBestScoreToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :best_score, :integer
  end
end
