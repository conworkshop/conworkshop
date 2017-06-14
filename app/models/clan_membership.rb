class ClanMembership < ApplicationRecord
  belongs_to :user
  belongs_to :clan
end
