# -*- coding: utf-8 -*-

module BoardUtil
  def rotated(grid, direction) # RT
    # もとのdirection の方向が上を向く
    return grid if direction == Direction::UP
    return rotated (rotated grid,Direction::DOWN), Direction::LEFT if direction == Direction::RIGHT
    return rotated (rotated grid, Direction::LEFT), Direction::LEFT if(direction == Direction::DOWN)
    # 右に90度回転 つまり
    # [[grid[3][0], grid[2][0], grid[1][0], grid[0][0]],
    #  [grid[3][1], grid[2][1], grid[1][1], grid[0][1]],
    #  [grid[3][2], grid[2][2], grid[1][2], grid[0][2]],
    #  [grid[3][3], grid[2][3], grid[1][3], grid[0][3]]]
    newGrid = Array.new(4).map{Array.new(4,0)}
    4.times {|i| 
      3.downto(0) {|j| newGrid[i][3-j] = grid[j][i] }
    }
    return newGrid 
  end

  def self.moveUPImp(tmp)
    4.times do |j|
      joined = false
      next if tmp[j] == 0
      (j-1).downto(0) do |k|
        next if tmp[k] == 0
        if tmp[k] == tmp[j] && ! joined
          tmp[k] *= 2
          tmp[j] = 0
          joined = true
        else
          unless k + 1 == j
            tmp[k+1] = tmp[j]
            tmp[j] = 0
          end
          joined = false
        end
        break
      end
    end
  end

  def self.moveUP(grid)
    newGrid = Array.new(4).map{Array.new(4,0)}
    4.times do |i|
      tmp = Array.new(4,0)
      4.times {|j| tmp[j] = grid[j][i] }
      moveUPImp(tmp)
      4.times {|j| newGrid[j][i] = tmp[j] }
    end
    return newGrid
  end
  
  def moved(grid, direction) # RT
    return rotated (moveUP (rotated grid, Direction::RIGHT)), Direction::LEFT if direction == Direction::RIGHT
    return rotated (moveUP (rotated grid, Direction::DOWN)), Direction::DOWN if direction == Direction::DOWN
    return rotated (moveUP (rotated grid, Direction::LEFT)), Direction::RIGHT if direction == Direction::LEFT

    return moveUP(grid)
  end
  
  def takeNum(grid, n) # RT
    # 1 to 16
    return grid[(n-1)/4][(n-1)%4]
  end

  def decideDir(grid) # random
    return Direction::DIRS.sample
    # return Direction::UP
  end

  def staticEval(grid) # RT
    0
  end

  def showGrid(grid) # RT
    puts "+----+----+----+----+"
    4.times {|i| printf("+%4d+%4d+%4d+%4d+\n", grid[i][0], grid[i][1], grid[i][2], grid[i][3]) }
    puts "+----+----+----+----+"
  end

  module_function :rotated, :moved, :decideDir, :showGrid 
end
