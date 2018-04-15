class RemoveForeignKeyFromIssue < ActiveRecord::Migration[5.2]
  def change
    remove_reference :issues, :version_id, foreign_key: true
  end
end
