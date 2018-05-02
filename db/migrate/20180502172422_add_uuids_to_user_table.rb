class AddUuidsToUserTable < ActiveRecord::Migration[5.2]
  def up
    tables = %w[users]

    tables.each do |table|
      add_column table, :uuid, :uuid, default: 'gen_random_uuid()', null: false
    end
  end
end
