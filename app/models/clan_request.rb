class ClanRequest < ApplicationRecord
  belongs_to :user
  belongs_to :clan
end
