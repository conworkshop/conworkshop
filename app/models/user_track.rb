class UserTrack < ApplicationRecord
  belongs_to :user

  # Returns the status of the associated user.
  # @return [:online, :away, :offline] the current status
  def status
    if tracked_at > 5.minutes.ago # online if active in the last 5 minutes
      :online
    elsif tracked_at > 30.minutes.ago # away if active in the last 30 minutes
      :away
    else # offline otherwise
      :offline
    end
  end
end
