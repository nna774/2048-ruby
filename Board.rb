# -*- coding: utf-8 -*-
require 'open-uri'
require 'json'

module Direction
  UP    = 0
  RIGHT = 1
  DOWN  = 2
  LEFT  = 3
  DIRS = [UP, RIGHT, DOWN, LEFT]
  def anti(dir) # anti . anti == id
    return UP    if dir == UP
    return RIGHT if dir == LEFT
    return DOWN  if dir == DOWN
    return LEFT  if dir == RIGHT
  end
  module_function :anti
end

class Over < StandardError
end

class Board
  @endpoint = ""
  @session_id = ""
  @grid = []
  @throwExceptionAtOver = true
  
  def initialize(endpoint = "http://2048.semantics3.com", throwExceptionAtOver = true) # destractive
    @endpoint = endpoint
    @throwExceptionAtOver = throwExceptionAtOver
  end
  
  def start() # destractive
    js = {}
    open(@endpoint + "/hi/start/json") {|f|
      js = JSON.load(f)
    }
    @session_id = js["session_id"]
    @grid = js["grid"]
  end
  
  def move(direction) # destractive
    js = {}
    open(@endpoint + "/hi/state/" + @session_id + "/move/" + direction.to_s + "/json") {|f|
      js = JSON.load(f)
    }
    if js["over"] != false && @throwExceptionAtOver
      if @atOver.nil?
        raise Over, js.to_s
      end
    end
    @grid = js["grid"]
  end
  def status # const
    return @grid
  end
end

