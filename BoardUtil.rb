# -*- coding: utf-8 -*-

module BoardUtil
  def rotated(grid, direction) # RT
    # もとのdirection の方向が上を向く
    if direction == Direction::UP
      return grid
    end
    if direction == Direction::RIGHT
      return rotated (rotated grid,Direction::DOWN), Direction::LEFT
    end
    if(direction == Direction::DOWN)
      return rotated (rotated grid, Direction::LEFT), Direction::LEFT
    end
    # 右に90度回転
    [[grid[3][0], grid[2][0], grid[1][0], grid[0][0]],
     [grid[3][1], grid[2][1], grid[1][1], grid[0][1]],
     [grid[3][2], grid[2][2], grid[1][2], grid[0][2]],
     [grid[3][3], grid[2][3], grid[1][3], grid[0][3]]]
  end

  def moved(grid, direction) # RT
    if direction == Direction::RIGHT
      return rotated (moved (rotated grid, Direction::RIGHT), Direction::UP), Direction::LEFT
    end
    if direction == Direction::DOWN
      return rotated (moved (rotated grid, Direction::DOWN), Direction::UP), Direction::DOWN
    end
    if direction == Direction::LEFT
      return rotated (moved (rotated grid, Direction::LEFT), Direction::UP), Direction::RIGHT
    end
    newGrid = [[0,0,0,0], [0,0,0,0], [0,0,0,0], [0,0,0,0]]
    4.times do |i|
      tmp = [0,0,0,0]
      4.times do |j|
        tmp[j] = grid[j][i]
      end
      4.times do |j|
        joined = false
        if tmp[j] == 0
          next
        end
        (j-1).downto(0) do |k|
          if tmp[k] == 0
            next
          end
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
      4.times do |j|
        newGrid[j][i] = tmp[j]
      end
    end
    return newGrid
  end

  def takeNum(grid, n) # RT
    # 1 to 16
    return grid[(n-1)/4][(n-1)%4]
  end

  def decideDir(grid) # random
    r = Random.new()
    return Direction::DIRS[r.rand(4)]
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
