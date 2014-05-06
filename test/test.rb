#! /usr/bin/ruby
# -*- encoding: utf-8 -*-

require "test/unit"

require "../Board.rb"
require "../BoardUtil.rb"

FourSquare = [
              [1,2,3,4],
              [5,6,7,8],
              [9,10,11,12],
              [13,14,15,16]
             ]

OneTwo = [
          [0,0,0,0],
          [0,0,0,0],
          [0,0,0,0],
          [0,0,0,2]
         ]
OneTwo2 = [
           [0,0,0,0],
           [0,0,0,0],
           [0,0,0,0],
           [2,0,0,0]
         ]
OneTwo3 = [
           [0,0,0,2],
           [0,0,0,0],
           [0,0,0,0],
           [0,0,0,0]
         ]

TwoTwo = [
          [0,0,0,0],
          [0,0,0,0],
          [0,0,0,2],
          [0,0,0,2]
         ]

OneFour = [
           [0,0,0,0],
           [0,0,0,0],
           [0,0,0,0],
           [0,0,0,4]
          ]
OneFour2 = [
            [0,0,0,0],
            [0,0,0,0],
            [0,0,0,0],
            [4,0,0,0]
         ]

AllTwo = [
        [2,2,2,2],
        [2,2,2,2],
        [2,2,2,2],
        [2,2,2,2]
       ]
DownAllTwo = [
            [0,0,0,0],
            [0,0,0,0],
            [4,4,4,4],
            [4,4,4,4]
           ]
DownDownAllTwo = [
            [0,0,0,0],
            [0,0,0,0],
            [0,0,0,0],
            [8,8,8,8]
           ]

All = [
       FourSquare,
       OneTwo,
       OneTwo2,
       OneTwo3,
       TwoTwo,
       OneFour,
       OneFour2
      ]

class TestRotate < Test::Unit::TestCase
  def setup
    @grid = All
  end
  def test_rotareRightLeftShouldBeID
    @grid.each do |grid|
      assert_equal((BoardUtil::rotated (BoardUtil::rotated grid, Direction::LEFT), Direction::RIGHT), grid)
    end
  end
  def test_rotareThreeRightShouldBeLeft
    @grid.each do |grid|
      assert_equal((BoardUtil::rotated (BoardUtil::rotated (BoardUtil::rotated grid, Direction::RIGHT), Direction::RIGHT), Direction::RIGHT), (BoardUtil::rotated grid, Direction::LEFT))
    end
  end
end


class TestMove < Test::Unit::TestCase
  def setup
    @grid = All
  end
  def test_TowTowDownIsOneFour
    assert_equal(OneFour, BoardUtil::moved(TwoTwo, Direction::DOWN))
  end
  def test_AllTwoUpIsDownAllTwosRotateDown
    assert_equal(BoardUtil::rotated(DownAllTwo, Direction::DOWN), BoardUtil::moved(AllTwo, Direction::UP))
  end
  def test_AllTwoDownIsDownAllTwo
    assert_equal(DownAllTwo, BoardUtil::moved(AllTwo, Direction::DOWN))
  end
  def test_DownAllTwoDownIsDownDownAllTwo
    assert_equal(DownDownAllTwo, BoardUtil::moved(DownAllTwo, Direction::DOWN))
  end
end





