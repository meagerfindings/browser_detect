class Portal < ApplicationRecord
  default_scope -> { order("created_at ASC") }
  has_many :versions, dependent: :destroy
  has_many :portal_issues, dependent: :destroy

  validates :name, uniqueness: true, presence: true
  validates :current, numericality: { only_integer: true }, presence: true
end