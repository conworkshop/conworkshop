# frozen_string_literal: true
class Profile < ApplicationRecord
  mount_uploader :avatar, AvatarUploader

  belongs_to :user

  validates :country, inclusion: { in: ISO3166::Country.codes, allow_blank: true }
  validates :gender, inclusion: { in: CWS::Globals::GENDER_CODES, allow_blank: true }
  validates :about, length: { maximum: 1000, allow_blank: true }

  def display_gender
    gender.present? ? CWS::Globals::GENDER_CODES[gender] : 'Not stated'
  end

  def display_country
    country.present? ? ISO3166::Country[country] : 'Nowhereland'
  end
end
