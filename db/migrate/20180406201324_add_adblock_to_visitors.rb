class AddAdblockToVisitors < ActiveRecord::Migration[5.2]
  def change
    add_column :visitors, :adblock, :boolean
  end
end
