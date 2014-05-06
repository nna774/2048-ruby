#! /usr/bin/ruby
# -*- encoding: utf-8 -*-

require './Board.rb'
require './BoardUtil.rb'

endpoint = "http://ring:2048"

# b = Board.new(endpoint)
# r = Random.new(1234)

# showGrid b.start

# begin 
#   1000.times do
#     b.move(Direction::DIRS[r.rand(4)])
#   end
# rescue => err
#   puts err
# end

# showGrid b.status

b = Board.new(endpoint)
b.start

begin
  while (true) # main loop
    dir = decideDir(b.status)
    #p dir
    p b.move(dir)
    showGrid (b.status)
  end
rescue => over
  p over
  showGrid (b.status)
end
