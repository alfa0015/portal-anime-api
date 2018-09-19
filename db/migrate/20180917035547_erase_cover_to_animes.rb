class EraseCoverToAnimes < ActiveRecord::Migration[5.2]

  def uo
    remove_attachment :animes, :cover
  end
  
  def down
    add_attachment :animes, :cover
  end
end
