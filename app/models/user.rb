require "uri"

# Regex constants
EMAIL_REGEX ||= URI::MailTo::EMAIL_REGEXP
USERNAME_REGEX ||= /\A[A-Za-z\d\-_]{4,}\z/.freeze
PASSWORD_REGEX ||= /\A
  (?=.*[A-Z])               # Uppercase
  (?=.*[a-z])               # Lowercase
  (?=.*\d)                  # Number
  (?=.*[[:^alnum:]])        # Symbol    
  (?=.{8,})                 # At least 8 chars
  /x

class User < ApplicationRecord
  # Callbacks
  before_save { email.downcase! }

  # Associations
  has_many :drills, dependent: :destroy

  # Validations
  validates :username, presence: true,
                       uniqueness: true,
                       format: USERNAME_REGEX
  validates :email, presence: true,
                    uniqueness: true,
                    format: EMAIL_REGEX

  has_secure_password
  validates :password, confirmation: true,
                       format: PASSWORD_REGEX, on: :create
  validates :password, confirmation: true,
                       format: PASSWORD_REGEX,
                       allow_nil: true,
                       allow_blank: true, on: :update
end
