# frozen_string_literal: true
class Clan < ApplicationRecord
  extend FriendlyId

  PERMISSION_TYPES = %w(O R I).freeze

  friendly_id :name, use: [:slugged, :finders]

  has_many :clan_memberships
  has_many :users, through: :clan_memberships

  validates :name, presence: true, length: { maximum: 255 }, uniqueness: true
  validates :symbol, presence: true, length: { is: 1 }
  validates :colour, presence: true, format: { with: /\A#?(?:[A-F0-9]{3}){1,2}\z/i }
  validates :permission, presence: true, inclusion: { in: PERMISSION_TYPES }
  validates :description, presence: true
end
