require 'open-uri'
require 'json'

module Direction
  UP    = 0
  RIGHT = 1
  DOWN  = 2
  LEFT  = 3
  DIRS = [UP, RIGHT, DOWN, LEFT]
end

class Over < StandardError
end

class Board
  @endpoint = ""
  @session_id = ""
  @grid = []
  
  def initialize(endpoint = "http://2048.semantics3.com")
    @endpoint = endpoint
  end
  
  def start()
    js = {}
    open(@endpoint + "/hi/start/json") {|f|
      js = JSON.load(f)
    }
    @session_id = js["session_id"]
    @grid = js["grid"]
  end
  
  def move(direction)
    js = {}
    open(@endpoint + "/hi/state/" + @session_id + "/move/" + direction.to_s + "/json") {|f|
      js = JSON.load(f)
    }
    if js["over"] != false
      if @atOver.nil?
        raise Over, js.to_s
      end
    end
    @grid = js["grid"]
  end
  def status
    @grid
  end
end

def showGrid(grid)
  puts "+----+----+----+----+"
  4.times {|i| printf("+%4d+%4d+%4d+%4d+\n", grid[i][0], grid[i][1], grid[i][2], grid[i][3]) }
  puts "+----+----+----+----+"
end

