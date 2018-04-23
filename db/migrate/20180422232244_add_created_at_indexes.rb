class AddCreatedAtIndexes < ActiveRecord::Migration[5.2]
  def up
    add_index :issues, :created_at
    add_index :portals, :created_at
    add_index :versions, :created_at
    add_index :visitors, :created_at
  end
end
