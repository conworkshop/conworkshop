class ClanMembership < ApplicationRecord
  belongs_to :user
  belongs_to :clan
  after_initialize :init

  def self.clan_roles
    %w(A M).freeze
  end

  validates :role, presence: true, inclusion: { in: clan_roles }

  def init
    self.role ||= 'M'
  end
end
