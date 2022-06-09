class Fundamental < ApplicationRecord
  # Associations
  has_many :moves

  # Validations
  validates :name, presence: true,
                   uniqueness: true
  enum :type, %i(forward backward_or_lateral horn_slide flank slow_turn ttr hats_off)
end
