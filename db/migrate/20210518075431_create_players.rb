class CreatePlayers < ActiveRecord::Migration[6.1]
  def change
    create_table :players do |t|
      enable_extension :citext
      t.citext :name, null: false
      t.timestamps
    end

    add_index :players, :name, unique: true
  end
end
