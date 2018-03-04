class CreateTvshows < ActiveRecord::Migration[5.1]
  def up
    create_table :tvshows do |t|
      t.string :name,null: false
      t.string :synopsis
      t.integer :episodes , default:0 , null: false
      t.integer :seasons , default:1 , null: false
      t.timestamps
    end
  end

  def down
    drop_table :tvshows
  end
end
