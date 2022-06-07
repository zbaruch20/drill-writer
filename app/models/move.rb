class Move < ApplicationRecord
  # Associations
  belongs_to :drill
  belongs_to :fundamental
end
