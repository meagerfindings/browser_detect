# frozen_string_literal: true

class PortalIssue < ApplicationRecord
  belongs_to :portal

  validates :name, presence: true
  validates :description, presence: true,
                          length: { minimum: 5 }
end
