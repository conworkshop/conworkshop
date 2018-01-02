# frozen_string_literal: true

class Profile < ApplicationRecord
  mount_uploader :avatar, AvatarUploader

  belongs_to :user

  validates :country, inclusion: { in: ISO3166::Country.codes, allow_blank: true }
  validates :gender, inclusion: { in: CWS::Globals::GENDER_CODES, allow_blank: true }
  validates :about, length: { maximum: CWS::Globals::MAX_ABOUT_CHARS, allow_blank: true }

  def display_gender
    I18n.t(gender.presence || 'none', scope: %w[general gender])
  end

  def display_country
    country.present? ? ISO3166::Country[country] : I18n.t('general.nocountry')
  end

  def avatar?
    avatar.file.present?
  end

  def avatar_url
    avatar? ? avatar.url : 'prof_default.png'
  end
end
