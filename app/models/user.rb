class User < ApplicationRecord
  # Associations
  has_many :drills

  # Validations
  has_secure_password
end
