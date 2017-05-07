class UserTrack < ApplicationRecord
  belongs_to :user

  # Returns the status of the associated user.
  # @return [:online, :away, :offline] the current status
  def status
    if tracked_at > 15.minutes.ago # online if active in the last 15 minutes
      :online
    elsif tracked_at > 1.hour.ago # away if active in the last hour
      :away
    else
      :offline
    end
  end
end
