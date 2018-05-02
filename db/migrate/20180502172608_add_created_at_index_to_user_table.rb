class AddCreatedAtIndexToUserTable < ActiveRecord::Migration[5.2]
  def up
    add_index :users, :created_at
  end
end
