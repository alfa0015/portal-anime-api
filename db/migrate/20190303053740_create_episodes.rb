class CreateEpisodes < ActiveRecord::Migration[5.2]
  def change
    create_table :episodes do |t|
      t.references :anime, foreign_key: true
      t.timestamps
    end
  end
  def down
    drop_table :episodes
  end
end
