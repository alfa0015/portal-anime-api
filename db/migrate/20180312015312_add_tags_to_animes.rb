class AddTagsToAnimes < ActiveRecord::Migration[5.1]

  def change
    enable_extension "hstore"
    add_column :animes, :tags, :hstore, array:true
  end

end
