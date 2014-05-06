# -*- coding: utf-8 -*-
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
  newGrid = [[]]
  4.times do |i|
    tmp = []
    if takeNum grid, i == 0
      next
    end
    if i <= 4
      newGrid[(i-1)/4][(i-1)%4] = takeNum grid, i
      next
    end
    
  end
end

def takeNum(grid, n) # 1 to 16
  return grid[(n-1)/4][(n-1)%4]
end

def decideDir(grid)
  r = Random.new()
  return Direction::DIRS[r.rand(4)]
  # return Direction::UP
end

def staticEval(grid)
  0
end

def showGrid(grid) # RT
  puts "+----+----+----+----+"
  4.times {|i| printf("+%4d+%4d+%4d+%4d+\n", grid[i][0], grid[i][1], grid[i][2], grid[i][3]) }
  puts "+----+----+----+----+"
end

