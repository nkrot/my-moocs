#!/usr/bin/ruby

require 'test/unit'

require_relative './hw6graphics'
require_relative './hw6provided'
require_relative './hw6assignment'

class TestMyTetris < Test::Unit::TestCase
#  def setup
#    @tetris = MyTetris.new
#  end

  def test_number_of_pieces
    assert_equal 10, MyPiece::All_My_Pieces.length
  end

  def test_cheat_piece
    # test piece should be a 3-dimentional array
    assert MyPiece::Cheat_Piece.is_a?(Array)
    assert MyPiece::Cheat_Piece[0].is_a?(Array)
    assert MyPiece::Cheat_Piece[0][0].is_a?(Array)
  end

  # oops :(
#  def test_key_bindings
#    @tetris = MyTetris.new
#    puts @tetris.instance_variable_get(:@root).inspect
#  end
end
