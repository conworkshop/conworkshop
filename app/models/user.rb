class User < ApplicationRecord
  devise :uid, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :username, presence:   true,
                       uniqueness: { case_sensitive: false },
                       format:     { with: /\A[a-zA-Z_\-\.]+\z/ },
                       length:     { minimum: 4, maximum: 16 }

  def display_name
    pseudonym ? pseudonym : username
  end

end
