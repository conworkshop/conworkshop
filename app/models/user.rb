# frozen_string_literal: true
class User < ApplicationRecord
  has_one :profile

  devise :uid, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :username, presence:   true,
                       uniqueness: { case_sensitive: false },
                       format:     { with: /\A[a-zA-Z_\-.]+\z/ },
                       length:     { minimum: 4, maximum: 16 }

  validates :pseudonym, uniqueness: { case_sensitive: false },
                        length:     { minimum: 4, maximum: 16 },
                        if:      -> { !(new_record? || pseudonym.blank?) }

  RANK_HIERARCHY = {
    B: 0, R: 0,
    S: 1,
    A: 2, D: 2
  }.freeze

  # Use username instead of id for linking to users
  def to_param
    username
  end

  def avatar?
    profile.avatar.present?
  end

  def avatar_url
    avatar? ? profile.avatar.url : 'prof_default'
  end

  # Get display name of a user (pseudonym if set, else username)
  def display_name
    pseudonym || username
  end

  def rank?(rank)
    RANK_HIERARCHY[group.to_sym] >= rank
  end

  # Whether user has editing rights over another
  # TODO: Allow ranks power over lower ranks (e.g admins > staff > members, etc)
  def power_over?(test_user)
    self == test_user || RANK_HIERARCHY[group.to_sym] > RANK_HIERARCHY[test_user.group.to_sym]
  end

  # convert datetime to the user's timezone (or UTC if not set)
  def to_user_timezone(datetime)
    tz = try(:timezone) || 'UTC'
    Time.at(datetime).in_time_zone(tz)
  end
end
