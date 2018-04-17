class Portal < ApplicationRecord
  has_many :versions, dependent: :destroy
  validates :name, uniqueness: true, presence: true
  validates :current, numericality: { only_integer: true }, presence: true
end
