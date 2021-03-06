class Move < ApplicationRecord
  # Callbacks
  # before_create :assign_next_valid_position
  before_destroy :decrement_succeeding_positions
  before_save :stringify

  # Associations
  belongs_to :drill
  belongs_to :fundamental

  # Validations
  validates :num_eights, numericality: { greater_than_or_equal_to: 1 },
                         allow_nil: true
  validates :position, numericality: { greater_than_or_equal_to: 0 },
                       allow_nil: true # This lets the model automatically set the position without angering the validation
  validate :validate_fundamental_type

  private

  # Sets the move's position to the next valid position of a move for its associated drill.
  # This method is executed when a Move is first saved to the database.
  def assign_next_valid_position
    self.position = Move.where(drill_id: drill_id).size
  end

  # Validates the move's fundamental type in relation to its surrounding types.
  # For example, you cannot have turns back to back.
  def validate_fundamental_type
    # Set position if not defined in create method
    self.position ||= assign_next_valid_position

    prev_move = Move.find_by drill_id: drill_id, position: position - 1
    prev_fund = prev_move&.fundamental

    next_move = Move.find_by drill_id: drill_id, position: position + 1
    next_fund = next_move&.fundamental

    turns = %w(flank slow_turn ttr)
    is_b2b_turns = (turns.include? prev_fund&.move_type) or (turns.include? next_fund&.move_type)

    is_first_move = prev_move.nil?
    is_last_move = next_move.nil?

    case self.fundamental.move_type
    when :forward
      errors.add(:base, "Number of eights must be specified") if num_eights.nil?
    when :backward_or_lateral
      errors.add(:base, "Number of eights must be specified") if num_eights.nil?
      errors.add(:base, "Can't have a TTR before or after a backward or lateral move") if prev_fund&.ttr? or next_fund&.ttr?
    when :horn_slide
      errors.add(:base, "Number of eights must be specified") if num_eights.nil?
      errors.add(:base, "Can't have a flank before or after a horn slide") if prev_fund&.flank? or next_fund&.flank?
    when :flank
      errors.add(:base, "Can't have back-to-back turns") if is_b2b_turns
    when :slow_turn
      errors.add(:base, "Number of counts must be specified") if num_eights.nil?
      errors.add(:base, "Can't have back-to-back turns") if is_b2b_turns
    when :ttr
      errors.add(:base, "First move can't be a TTR") if is_first_move
      errors.add(:base, "Can't have back-to-back turns") if is_b2b_turns
    when :hats_off
      errors.add(:base, "Hats off is only allowed for horns up drills") unless drill.horns_up_up? or drill.horns_up_down?
      errors.add(:base, "Can't have hats off if drill ends with horns up") if is_last_move and drill.horns_up_up?
    end
  end

  # Decrements the position attribute of moves ahead of self in the drill.
  # This method is executed when a Move is destroyed.
  def decrement_succeeding_positions
    query = "drill_id = :drill_id and position > :position"

    # Decrement position on each succeeding move
    Move.where(query, drill_id: drill_id, position: position).each { |m| m.position -= 1 }
  end

  # Updates the string representation based on current attributes.
  # This method is called each time a Move is saved to the database.
  def stringify
    moves_with_eights = %w(forward backward_or_lateral horn_slide)
    self.string = ""

    if fundamental.hats_off?
      is_last_move = Move.find_by(drill_id: drill_id, position: position + 1).nil?
      self.string = "Halt kick down, hats off #{is_last_move ? "Ohio on the end" : "1-2-3"}"
    else
      if moves_with_eights.include? fundamental.move_type
        self.string << "#{num_eights} "
        self.string << "#{"eight".pluralize num_eights} of " unless ["step side", "side step"].include? fundamental.name
      end
      self.string << fundamental.name
      self.string << " in #{num_eights} #{"count".pluralize num_eights}" if fundamental.slow_turn?
      self.string.split[0].capitalize!
    end
  end
end
