class AddBannerToAnimes < ActiveRecord::Migration[5.1]
  def up
    add_attachment :animes, :banner
  end

  def down
    remove_column :animes, :banner
  end
end
