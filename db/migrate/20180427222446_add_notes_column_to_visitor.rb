class AddNotesColumnToVisitor < ActiveRecord::Migration[5.2]
  def change
    add_column :visitors, :notes, :text
  end
end
