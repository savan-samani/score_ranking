class CreateScores < ActiveRecord::Migration[6.1]
  def change
    create_table :scores do |t|
      t.belongs_to :player, null: false, foreign_key: true
      t.integer :score_point, null: false
      t.datetime :score_at, null: false

      t.timestamps
    end
  end
end
