class ConsoleInteractor
  def draw(message)
    puts message
  end

  def receive_input
    return gets.chomp
  end
end
