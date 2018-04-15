class AddNewForeignKeyToVersions < ActiveRecord::Migration[5.2]
  def change
    add_reference :versions, :portal, foreign_key: true
  end
end
