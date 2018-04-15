class Version < ApplicationRecord
  has_many :issues, dependent: :destroy
  validates :number, presence: true
end
