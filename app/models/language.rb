# frozen_string_literal: true
class Language < ApplicationRecord
  belongs_to :user
  has_one :lang_type

  validates :code,
            presence: true,
            uniqueness: true,
            length: { is: 3 },
            format: { with: /\A[A-Z0-9]{3}\z/ }
end
