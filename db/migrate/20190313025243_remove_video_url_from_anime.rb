class RemoveVideoUrlFromAnime < ActiveRecord::Migration[5.2]
  def up
    remove_column :animes, :video_url
  end
  def down
    add_column :animes, :video_url
  end
end
