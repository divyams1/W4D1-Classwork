require_relative 'tic_tac_toe_node'
require "byebug"
class SuperComputerPlayer < ComputerPlayer
  def move(game, mark)
    node = TicTacToeNode.new(game.board, mark)
    moves = node.children
    moves.each do |play|
      return play.prev_move_pos if play.winning_node?(mark)
    end

    moves.each do |play|
      return play.prev_move_pos if !play.losing_node?(mark)
    end
    raise 
    end
    
  
end

if __FILE__ == $PROGRAM_NAME
  puts "Play the brilliant computer!"
  hp = HumanPlayer.new("Jeff")
  cp = SuperComputerPlayer.new

  TicTacToe.new(hp, cp).run
end
