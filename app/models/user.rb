class User < ApplicationRecord
  devise :uid, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :username, presence:   true,
                       uniqueness: { case_sensitive: false },
                       format:     { with: /\A[a-zA-Z_\-.]+\z/ },
                       length:     { minimum: 4, maximum: 16 }

  validates :pseudonym, uniqueness: { case_sensitive: false },
                        format:     { with: /\A[a-zA-Z_\-.]+\z/ },
                        length:     { minimum: 4, maximum: 16 },
                        if:         -> { new_record? || !pseudonym.blank? }

  # Use username instead of id for linking to users
  def to_param
    username
  end

  # Get display name of a user (pseudonym if set, else username)
  def display_name
    pseudonym ? pseudonym : username
  end

  # Whether user has editing rights over another
  # TODO: Allow ranks power over lower ranks (e.g admins > staff > members, etc)
  def power_over(test_user)
    self == test_user ? true : false
  end

  # convert datetime to the user's timezone (or UTC if not set)
  def to_user_timezone(datetime)
    tz = try(:timezone) || 'UTC'
    Time.at(datetime).in_time_zone(tz)
  end
end
