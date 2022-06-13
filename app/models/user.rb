require "uri"

# Regex constants
EMAIL_REGEX ||= URI::MailTo::EMAIL_REGEXP
USERNAME_REGEX ||= /\A[A-Za-z\d\-_]{4,}\z/.freeze
PASSWORD_REGEX ||= /\A(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%\^&*()\-=_+\[\]{}\\|;:'",.\/<>?`~])\S{8,}\z/.freeze

class User < ApplicationRecord
  # Callbacks
  before_save { email.downcase! }

  # Associations
  has_many :drills, dependent: :destroy

  # Validations
  validates :username, presence: true,
                       uniqueness: true,
                       format: { with: USERNAME_REGEX }
  validates :email, presence: true,
                    uniqueness: true,
                    format: { with: EMAIL_REGEX }
  has_secure_password
  validates :password, presence: true,
                       confirmation: true,
                       format: { with: PASSWORD_REGEX },
                       allow_nil: true # for debugging/testing, comment this out upon production
end
