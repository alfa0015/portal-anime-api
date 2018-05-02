class AddCoverToAnimes < ActiveRecord::Migration[5.1]

  def up
    add_attachment :animes, :cover
  end

  def down
    remove_attachment :animes, :cover
  end

end
