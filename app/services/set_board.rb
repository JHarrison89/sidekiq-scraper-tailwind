# frozen_string_literal: true

# Finds or creates an Board
class SetBoard
  def self.call(name:)
    # We're making an assumption that boards will be set up manually
    # when scripts are created, so unlike employers, we won't be setting
    # logos on the fly
    Board.find_or_create_by(name:)
  end
end
