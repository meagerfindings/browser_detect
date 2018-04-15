class AddForeignKeyToIssue < ActiveRecord::Migration[5.2]
  def change
    add_reference :issues, :version_id, foreign_key: true
  end
end
