class CreatePortals < ActiveRecord::Migration[5.2]
  def change
    create_table :portals do |t|
      t.string :name

      t.timestamps
    end
  end
end
