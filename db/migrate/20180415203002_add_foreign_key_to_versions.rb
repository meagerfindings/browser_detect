class AddForeignKeyToVersions < ActiveRecord::Migration[5.2]
  def change
    add_reference :versions, :portal_id, foreign_key: true
  end
end
