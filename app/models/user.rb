# frozen_string_literal: true
class User < ApplicationRecord
  RANK_HIERARCHY = {
    B: 0, R: 0,
    S: 1,
    A: 2, D: 2
  }.freeze

  USERNAME_LEN  = (4..16).freeze

  has_one :profile
  has_one :user_track

  has_many :languages
  belongs_to :current_lang, class_name: 'Language'

  has_many :clans, through: :clan_memberships
  belongs_to :default_clan, class_name: 'Clan'

  after_create :create_profile, :create_user_track

  devise :uid, :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:facebook]

  store :preferences, accessors: [:locale], coder: JSON

  validates :username, presence:   true,
                       uniqueness: { case_sensitive: false },
                       format:     { with: /\A[A-Za-z0-9_\-.]+\z/ },
                       length:     USERNAME_LEN

  validates :pseudonym, uniqueness: { case_sensitive: false },
                        length:     { minimum: USERNAME_LEN.begin },
                        if:      -> { !(new_record? || pseudonym.blank?) }

  validates_hash_keys :preferences do
    validates :locale, allow_blank: true,
                       inclusion: {
                         in: I18n.available_locales.map(&:to_s),
                         message: '%{value} is not available in ConWorkShop'
                       }
  end

  def self.from_omniauth(auth)
    ActiveRecord::Base.transaction do
      u = where(
        '(oaid = ? AND provider = ?) OR email = ?',
        auth.uid,
        auth.provider,
        auth.info.email
      ).first_or_initialize(oaid: auth.uid, provider: auth.provider) do |u|
        u.email     = auth.info.email
        u.password  = Devise.friendly_token
        u.username  = Devise.friendly_token(USERNAME_LEN.begin + 5)
        u.pseudonym = auth.info.name
        u.group     = 'R'

        u.profile = Profile.new

        u.profile.user = u
        u.profile.remote_avatar_url = auth.info.image.sub('http', 'https') if auth.info.image
      end

      # update oaid and provider in case of standard user trying to login with facebook
      if u.persisted? && u.email == auth.info.email && u.oaid.blank?
        u.oaid      = auth.uid
        u.provider  = auth.provider
        u.auth_type = 2 # flag standard+facebook

        u.save(validate: false)
      elsif !u.persisted?
        u.save!
      end

      u
    end
  end

  def self.new_from_session(params, session)
    super.tap do |user|
      if (data = session['devise.facebook_data']) && session['devise.facebook_data']['extra']['raw_info']
        user.email = data['email'] if user.email.blank?
      end
    end
  end

  # Use username instead of id for linking to users
  def to_param
    username
  end

  # Get display name of a user (pseudonym if set, else username)
  def display_name
    pseudonym || username
  end

  def user_clan
    default_clan ? default_clan : Clan.find('conlanger')
  end

  def in_clan?(c)
    ClanMembership.exists?(user: self, clan: c)
  end

  def rank?(rank)
    RANK_HIERARCHY[group.to_sym] >= rank
  end

  # Whether user has editing rights over another
  def power_over?(test_user)
    return false if test_user.nil?

    self == test_user || RANK_HIERARCHY[group.to_sym] > RANK_HIERARCHY[test_user.group.to_sym]
  end

  def banned?
    group == 'B'
  end
end
