# frozen_string_literal: true

class Diacritic < ApplicationRecord

  #more soon, diacritics are also useful for phonology modifiers like in the old CWS

  validates :sampa, presence: true, uniqueness: true
  validates :ipa, presence: true, uniqueness: true
  validates :name, presence: true, uniqueness: true

  def to_param
    name
  end

end
