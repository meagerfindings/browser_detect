class AddForeignKeyToPortalIssues < ActiveRecord::Migration[5.2]
  def change
    add_column :portal_issues, :portal_id, :bigint
    add_foreign_key :portal_issues, :portals
  end
end
