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
      hit = false
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
        hit = true
        break
      end
      if j != 0 && ! hit
        tmp[0] = tmp[j]
        tmp[j] = 0
        joined = false
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
    return rotated (moveUP (rotated grid, Direction::anti(direction))), direction unless direction == Direction::UP

    return moveUP(grid)
  end
  
  def takeNum(grid, n) # RT
    # 1 to 16
    return grid[(n-1)/4][(n-1)%4]
  end

  def self.staticEval(grid) # RT
    return grid.flatten.inject(:+)
  end
  
  def decideDir(grid) # random
    npw = nextPossibleWorld(grid)
    return npw.map{|x|
      { score: staticEval(x[:grid]), dir: x[:dir] }
    }.max{|a,b| a[:score] <=> b[:score]}[:dir]
  end

  def showGrid(grid) # RT
    puts "+----+----+----+----+"
    4.times {|i| printf("+%4d+%4d+%4d+%4d+\n", grid[i][0], grid[i][1], grid[i][2], grid[i][3]) }
    puts "+----+----+----+----+"
  end
  
  def self.nextPossibleWorldUP(grid, dir)
    up = moveUP(grid)
    # return [{grid: up, dir: dir}] if up == grid # 動かせなかった場合変わらない
    #                                             # 枝刈りに不利かもしれない
     return [] if up == grid
    ups = []
    4.times do |i|
      4.times do |j|
        if up[j][i] == 0
          tmp  = Array.new(4).map{Array.new(4,0)}
          tmp2 = Array.new(4).map{Array.new(4,0)}
          4.times {|k| 4.times {|l| tmp2[k][l]=tmp[k][l]=up[k][l] }} # deepcopy
          tmp[j][i]  = 2
          tmp2[j][i] = 4
          ups << {grid: tmp, dir: dir} << {grid: tmp2, dir: dir}
          break
        end
      end
    end
    return ups
  end
  
  def nextPossibleWorld(grid) # RT
    return Direction::DIRS.map{|dir|
      (nextPossibleWorldUP (rotated grid, dir), dir).map{|x|
        {grid: (rotated x[:grid], Direction::anti(dir)), dir: dir}
      }
    }.flatten(1)
  end
  module_function :rotated, :moved, :decideDir, :showGrid, :nextPossibleWorld
end
