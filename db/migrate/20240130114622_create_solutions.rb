class CreateSolutions < ActiveRecord::Migration[7.1]
  def change
    create_table :solutions do |t|
      t.references :match, null: false, foreign_key: true
      t.string :word

      t.timestamps
    end
  end
end
