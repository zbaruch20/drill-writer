class Move < ApplicationRecord
  # Callbacks
  before_create :assign_next_valid_position
  before_destroy :decrement_succeeding_positions

  # Associations
  belongs_to :drill
  belongs_to :fundamental

  # Validations
  validates :num_eights, numericality: { greater_than_or_equal_to: 1 },
                         allow_nil: true
  validates :position, numericality: { greater_than_or_equal_to: 0 }

  private

  # Sets the move's position to the next valid position of a move for its associated drill.
  # This method is executed when a Move is first saved to the database.
  def assign_next_valid_position
    self.position = self.where(drill_id: self.drill_id).size
  end

  # Validates the move's fundamental type in relation to its surrounding types.
  # For example, you cannot have turns back to back.
  def validate_fundamental_type
  end

  # Decrements the position attribute of moves ahead of self in the drill.
  # This method is executed when a Move is destroyed.
  def decrement_succeeding_positions
    QUERY = 'drill_id = :drill_id and position > :position'
    succeeding_moves = self.where(QUERY, drill_id: self.drill_id, position: self.position)
    succeeding_moves.each { |m| m.position -= 1 } # Decrement position on each succeeding move
  end
end
