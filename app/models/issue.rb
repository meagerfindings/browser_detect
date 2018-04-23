class Issue < ApplicationRecord
  default_scope -> { order("created_at ASC") }
  belongs_to :version

  validates :name, presence: true
  validates :description, presence: true,
                          length: { minimum: 5 }
end
