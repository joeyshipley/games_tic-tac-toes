class GameRunner
  # current responsibilities:
  # 1. manages running the game
  # 2. turning a game board into a displayable format
  # 3. maintaining the board/moves
  # 4. building the initial game board

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

    human_choice = @ux_interactor.receive_input
    assign_move(human_choice.to_i, :human) unless human_choice.nil?
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

  def get_display_value_for_move_owner( moves, square )
    move = get_move_from(moves, square)
    return "X" if move.owner == :human
    return "O" if move.owner == :computer
    return square if move.owner == :none
  end

  def assign_move( square, owner )
    update_move_from(@moves, square, owner)
  end

  def update_move_from( moves, square, owner )
    move = get_move_from(moves, square)
    move.owner = owner
  end

  def get_move_from( moves, square )
    move = moves.find { |move| move.square == square }
    return move
  end
end
