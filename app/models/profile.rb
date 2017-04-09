# frozen_string_literal: true
class Profile < ApplicationRecord
  mount_uploader :avatar, AvatarUploader

  belongs_to :user

  def display_gender
    gender || 'Not stated'
  end

  def display_country
    country || 'Nowhereland'
  end
end
