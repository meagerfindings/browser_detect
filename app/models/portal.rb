class Portal < ApplicationRecord
  has_many :versions, dependent: :destroy
  validates :name, presence: true
  validates :current, presence: true
end
