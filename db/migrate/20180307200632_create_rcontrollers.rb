class CreateRcontrollers < ActiveRecord::Migration[5.1]
  def up
    create_table :rcontrollers do |t|
      t.string :name

      t.timestamps
    end
  end

  def down
    drop_table :rcontrollers
  end
end
