class Drill < ApplicationRecord
  # Assocations
  belongs_to :user
  has_many :moves, dependent: :destroy

  # Validations
  validates :name, presence: true,
                   length: { maximum: 50 }
  validates :ramp_cadences, numericality: { greater_than_or_equal_to: 0 },
                            allow_nil: true
  enum :style, %i(horns_down horns_up_down horns_up_up ramp)
end
