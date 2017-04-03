class User < ApplicationRecord
  devise :uid, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :username, presence:   true,
                       uniqueness: { case_sensitive: false },
                       format:     { with: %r{\A[a-zA-Z_\-\.]+\z/} },
                       length:     { minimum: 4, maximum: 16 }

  # Get display name of a user (pseudonym if set, else username)
  def display_name
    pseudonym ? pseudonym : username
  end

  # convert datetime to the user's timezone (or UTC if not set)
  def to_user_timezone(datetime)
    tz = try(:timezone) || 'UTC'
    Time.at(datetime).in_time_zone(tz)
  end
end
