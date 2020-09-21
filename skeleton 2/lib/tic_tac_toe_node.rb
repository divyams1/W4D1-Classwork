require_relative 'tic_tac_toe'
require "byebug"
require_relative "super_computer_player"
class TicTacToeNode

  attr_reader :board, :next_mover_mark, :prev_move_pos

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @marks = [:o, :x]
    @board = board
    @next_mover_mark = next_mover_mark
    @mark_index = @marks.index(next_mover_mark)
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)
    
    return false if @board.over? && @board.winner == nil
    return true if @board.over? && @board.winner != evaluator 
    return false if @board.over? && @board.winner == evaluator 
    if evaluator == @next_mover_mark 
      return true if self.children.all? {|child| child.losing_node?(evaluator)} 
    end 
    if evaluator != @next_mover_mark
      return true if self.children.any? {|child| child.losing_node?(evaluator)}
    end
    
    return false
      
  end


  def winning_node?(evaluator) 
    return true if @board.winner == evaluator && @board.over?
    return false if @board.over? && @board.winner != evaluator
    if @next_mover_mark == evaluator
      return true if self.children.any?{|child| child.winning_node?(evaluator)}
    else
      return true if self.children.all?{|child| child.winning_node?(evaluator)}
    end
      
    return false
  end

  def switch_mark
    if @mark_index == 0
      @marks[1]
    else
      @marks[0]
    end
  end

  # This method generates an array of all moves that can be made after
  # the current move.                                                                           | | | |
  def children
    potential_moves = []
    @board.rows.each_with_index do |row, i|
      row.each_with_index do |ele, j|
        pos = [i, j]
        potential_moves << pos if @board.empty?(pos)
      end
    end
    
    new_mark = self.switch_mark
    potential_moves.map! do |pos|
      new_board = @board.dup  
      new_board[pos] = next_mover_mark
      self.class.new(new_board, new_mark, pos)
    end
    
    return potential_moves
  end

end
  