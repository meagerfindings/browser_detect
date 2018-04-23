# frozen_string_literal: true

class AddUuidsToEveryTable < ActiveRecord::Migration[5.2]
  def up
    tables = %w[
      issues
      portals
      versions
      visitors
    ]

    tables.each do |table|
      add_column table, :uuid, :uuid, default: 'gen_random_uuid()', null: false
    end
  end
end
