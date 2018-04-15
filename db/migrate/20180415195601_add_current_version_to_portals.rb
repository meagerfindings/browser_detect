class AddCurrentVersionToPortals < ActiveRecord::Migration[5.2]
  def change
    add_column :portals, :current, :integer
  end
end
