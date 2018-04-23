class Version < ApplicationRecord
  default_scope -> { order("created_at ASC") }

  has_many :issues, dependent: :destroy

  belongs_to :portal

  validates :number,
            uniqueness: { message: 'must be unique' },
            presence: { message: 'cannot be blank' }
end
