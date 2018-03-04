class AddTagsToTvshos < ActiveRecord::Migration[5.1]
  def up
    add_column :tvshows, :tags,:hstore, array: true
  end

  def down
    remove_column :tvshows, :tags, :hstore, array: true
  end
end
