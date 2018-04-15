class CreateVersions < ActiveRecord::Migration[5.2]
  def change
    create_table :versions do |t|
      t.integer :number

      t.timestamps
    end
  end
end
