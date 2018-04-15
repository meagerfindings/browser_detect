class RemoveForeignKeyFromVersion < ActiveRecord::Migration[5.2]
  def change
    remove_reference :versions, :portal_id, foreign_key: true
  end
end
