# frozen_string_literal: true

class ClanMembership < ApplicationRecord
  CLAN_ROLES = %w[A M].freeze

  belongs_to :user
  belongs_to :clan

  after_initialize :init

  validates :role, presence: true, inclusion: { in: CLAN_ROLES }

  def init
    self.role ||= 'M'
  end
end
