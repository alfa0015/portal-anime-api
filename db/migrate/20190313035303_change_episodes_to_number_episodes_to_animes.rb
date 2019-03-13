class ChangeEpisodesToNumberEpisodesToAnimes < ActiveRecord::Migration[5.2]
  def up
    rename_column :animes, :episodes, :number_episodes
  end
  def down
    rename_column :animes, :number_episodes, :episodes
  end
end
