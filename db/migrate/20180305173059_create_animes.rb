class CreateAnimes < ActiveRecord::Migration[5.1]
  def up
    create_table :animes do |t|
      t.string :name
      t.text :synopsis
      t.integer :sessions
      t.integer :episodes

      t.timestamps
    end
  end

  def down
    drop_table :animes
  end
end
