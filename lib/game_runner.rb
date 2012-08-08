class GameRunner
  # current responsibilities:
  # 1. manages running the game
  # 2. turning a game board into a displayable format
  # 3. maintaining the board/moves
  # 4. building the initial game board
  # 5. validates the players move

  attr_accessor :moves

  def initialize(ux_interactor, game_message_provider)
    @ux_interactor = ux_interactor
    @message_provider = game_message_provider
    build_game_board
  end

  def start
    @ux_interactor.draw @message_provider.game_start
    @ux_interactor.draw game_board_to_s
    @ux_interactor.draw @message_provider.ask_for_human_move

    human_choice = @ux_interactor.receive_input.to_i
    is_move_valid = move_is_valid(human_choice)
    unless is_move_valid
      @ux_interactor.draw @message_provider.invalid_move
    else
      is_move_taken = move_is_taken(human_choice)
      @ux_interactor.draw @message_provider.move_already_taken if is_move_taken
      update_move(human_choice, :human) unless human_choice.nil? or is_move_taken
    end
  end

  def move_is_valid(square)
    patternMatch = square.to_s =~ /[1-9]/
    return patternMatch.nil? ? false : true
  end

  def move_is_taken(square)
    move = @moves.find { |move| move.square == square }
    return true unless move.nil? or move.owner == :none
    return false
  end

  def build_game_board
    moves = [
      Move.new( 1, :none ),
      Move.new( 2, :none ),
      Move.new( 3, :none ),
      Move.new( 4, :none ),
      Move.new( 5, :none ),
      Move.new( 6, :none ),
      Move.new( 7, :none ),
      Move.new( 8, :none ),
      Move.new( 9, :none )
    ]
    @moves = moves
  end

  def game_board_to_s
    square1 = get_display_value_for_move_owner(@moves, 1)
    square2 = get_display_value_for_move_owner(@moves, 2)
    square3 = get_display_value_for_move_owner(@moves, 3)
    square4 = get_display_value_for_move_owner(@moves, 4)
    square5 = get_display_value_for_move_owner(@moves, 5)
    square6 = get_display_value_for_move_owner(@moves, 6)
    square7 = get_display_value_for_move_owner(@moves, 7)
    square8 = get_display_value_for_move_owner(@moves, 8)
    square9 = get_display_value_for_move_owner(@moves, 9)

    board = ""
    board += "                   \n"
    board += "      |     |      \n"
    board += "   #{square1}  |  #{square2}  |  #{square3}   \n"
    board += "      |     |      \n"
    board += " ----- ----- ----- \n"
    board += "      |     |      \n"
    board += "   #{square4}  |  #{square5}  |  #{square6}   \n"
    board += "      |     |      \n"
    board += " ----- ----- ----- \n"
    board += "      |     |      \n"
    board += "   #{square7}  |  #{square8}  |  #{square9}   \n"
    board += "      |     |      \n"
    board += "                   \n"

    return board
  end

  def get_display_value_for_move_owner(moves, square)
    move = moves.find { |move| move.square == square }
    return "X" if move.owner == :human
    return "O" if move.owner == :computer
    return square if move.owner == :none
  end

  def update_move(square, owner)
    move = @moves.find { |move| move.square == square }
    move.owner = owner
  end
end
