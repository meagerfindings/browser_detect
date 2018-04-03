class CreateVisitors < ActiveRecord::Migration[5.2]
  def change
    create_table :visitors do |t|
      t.string :browser
      t.string :version
      t.string :third_cookies
      t.boolean :comp_mode
      t.boolean :css
      t.string :os
      t.string :email

      t.timestamps
    end
  end
end
