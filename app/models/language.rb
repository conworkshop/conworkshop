# frozen_string_literal: true
class Language < ApplicationRecord
  belongs_to :user
  has_one :lang_type

  validates :code,
            presence: true,
            uniqueness: true,
            length: { minimum: 3, maximum: 6 },
            format: { with: /[A-Z0-9]/ }
end
