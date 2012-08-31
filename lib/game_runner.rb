class GameRunner
  attr_accessor :board

  def initialize(interface, board, players, status, ai)
    @interface = interface
    @board = board
    @players = players
    @game_status = status
    @ai = ai
  end

  def start
    @winner = :none
    while @winner == :none do
      perform_turn
      check_game_status
    end
    output display_board
    output display_winner
  end

  def perform_turn
    output display_board
    perform_player_action
    check_game_status
    perform_computer_action if is_ok_for_computer_to_perform_action
  end

  def is_ok_for_computer_to_perform_action
    @winner == :none
  end

  def check_game_status
    @winner = @game_status.check_status(@board)
  end

  def perform_player_action
    ask_for_player_move
    player_choice = get_choice_from_player
    @board.apply_move(:player, player_choice)
  end

  def get_choice_from_player
    valid_choice = nil
    while valid_choice.nil? do
      player_choice = input
      valid_choice = player_choice if validate_move(player_choice)
    end
    valid_choice
  end

  def perform_computer_action
    computer_choice = @ai.calculate(@board)
    @board.apply_move(:computer, computer_choice)
  end

  def output(message)
    @interface.output message
  end

  def input
    @interface.input
  end

  def display_board
    @board.for_display
  end

  def ask_for_player_move
    output t.messages.choose_move
  end

  def validate_move(square)
    is_valid = is_move_valid(square)
    output message_for_invalid_move unless is_valid
    return false unless is_valid

    is_available = is_move_available(square)
    output message_for_move_already_taken unless is_available
    return false unless is_available

    true
  end

  def message_for_invalid_move
    t.messages.invalid_move
  end

  def message_for_move_already_taken
    t.messages.already_taken
  end

  def is_move_available(square)
    @board.is_tile_available(square)
  end

  def is_move_valid(square)
    @board.is_tile_valid(square)
  end

  def display_winner
    return t.messages.player_won if @winner == :player
    return t.messages.computer_won if @winner == :computer
    return t.messages.game_draw if @winner == :draw
  end
end
