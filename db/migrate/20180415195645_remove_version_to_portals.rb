class RemoveVersionToPortals < ActiveRecord::Migration[5.2]
  def change
    remove_column :portals, :version, :integer
  end
end
