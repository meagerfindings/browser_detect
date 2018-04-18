class Issue < ApplicationRecord
  belongs_to :version

  validates :name, presence: true
  validates :description, presence: true,
                          length: { minimum: 5 }
end
