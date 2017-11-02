class Game
  attr_accessor :board, :player_1, :player_2

  WIN_COMBINATIONS = [
    [0,1,2],
    [3,4,5],
    [6,7,8],
    [0,3,6],
    [1,4,7],
    [2,5,8],
    [0,4,8],
    [2,4,6]
  ]

  def initialize(player_1 = Players::Human.new("X"), player_2 = Players::Human.new("O") , board=Board.new)
    @board = board
    @player_1 = player_1
    @player_2 = player_2
  end

  def current_player
    board.turn_count.even? ? player_1 : player_2
  end

  def over?
    board.full? ? true : false
  end

  def won?
    winning_array = false
    WIN_COMBINATIONS.each do |combo|
      if (board.cells[combo[0]] == "X" && board.cells[combo[1]] == "X" && board.cells[combo[2]] == "X") || (board.cells[combo[0]] == "O" && board.cells[combo[1]] == "O" && board.cells[combo[2]] == "O")
        winning_array = combo
        break
      end
    end
    winning_array
  end

  def draw?
    over? && !won? ? true : false
  end

  def winner
    won? ? board.cells[won?[0]] : nil
  end

  def turn
    puts "Please enter 1-9:"
    player = current_player
    input = player.move(board)
    # binding.pry
    if !board.valid_move?(input)
      puts "invalid"
      turn
    else
      board.update(input, player)
      board.display

    end
  end

  def play
    while !over? && !won? && !draw?
      turn
    end
    if won?
      puts "Congratulations #{winner}!"
    elsif draw?
      puts "Cat's Game!"
    end
  end

end

# game = Game.new
# binding.pry
