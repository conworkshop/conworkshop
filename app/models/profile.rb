# frozen_string_literal: true
class Profile < ApplicationRecord
  mount_uploader :avatar, AvatarUploader

  belongs_to :user

  def display_gender
    gender.present? ? gender : 'Not stated'
  end

  def display_country
    country.present? ? ISO3166::Country[country] : 'Nowhereland'
  end
end
