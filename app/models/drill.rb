class Drill < ApplicationRecord
  # Callbacks
  before_save :stringify

  # Assocations
  belongs_to :user
  has_many :moves, dependent: :destroy

  # Validations
  validates :name, presence: true,
                   length: { maximum: 50 }
  validates :ramp_cadences, numericality: { greater_than_or_equal_to: 0 },
                            allow_nil: true
  enum :style, %i(horns_down horns_up_down horns_up_up ramp)

  private

  # Updates the before and after strings based on current parameters.
  # This method is called each time a Drill is saved to the database.
  def stringify
    # before_string
    if self.ramp?
      before_string = "Your drill is RAMP!!!! (WOOOOO!!!!) #{ramp_cadences == 0 ? "Cadences ad infinitum" : "#{ramp_cadences} cadences"}, "
      before_string << "play the first note, sing through the slow step, into:"
    else
      before_string = "Your drill is:"
    end

    # after_string
    after_string = ""
    last_fund = moves.max { |a, b| a.position <=> b.position }.fundamental
    if !last_fund.hats_off? # Hats off at end does its own thing
      after_string = "Halt kick#{" down" if self.horns_up_down? or self.ramp?}#{" rest 1-2-3" if self.ramp?}"
    end
  end
end
