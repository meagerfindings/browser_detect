class AddNewForeignKeyToIssue < ActiveRecord::Migration[5.2]
  def change
    add_reference :issues, :version, foreign_key: true
  end
end
