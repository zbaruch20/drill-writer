require "uri"

class User < ApplicationRecord
  include UserHelper

  # Associations
  has_many :drills, dependent: :destroy

  # Validations
  validates :username, presence: true,
                       uniqueness: true
  validates :email, presence: true,
                    uniqueness: true,
                    format: { with: UserHelper::EMAIL_REGEX }
  has_secure_password
  validates :password, presence: true,
                       confirmation: true,
                       format: { with: UserHelper::PASSWORD_REGEX },
                       allow_nil: true # for debugging/testing, comment this out upon production
end
