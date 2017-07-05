# frozen_string_literal: true
class Language < ApplicationRecord
  CODE_LENGTH = 3..6

  belongs_to :user
  belongs_to :lang_type

  validates :code,
            presence: true,
            uniqueness: true,
            length: CODE_LENGTH,
            format: { with: /[A-Z0-9]/ }

  validates :name,       presence: true
  validates :nativename, presence: true
  validates :user,       presence: true
end
