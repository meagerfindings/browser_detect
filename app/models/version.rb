class Version < ApplicationRecord
  has_many :issues, dependent: :destroy

  belongs_to :portal

  validates :number,
            uniqueness: { message: 'must be unique' },
            presence: { message: 'cannot be blank' }
end
