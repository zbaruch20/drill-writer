class Fundamental < ApplicationRecord
  # Validations
  validates :name, presence: true,
                   uniqueness: true
  enum :type, %i(forward backward_lateral horn_slide turn ttr hats_off)
end
