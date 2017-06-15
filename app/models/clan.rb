class Clan < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged
  validates :name, presence: true, length: { maximum: 255 }, uniqueness: true
end
