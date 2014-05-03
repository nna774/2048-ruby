#! /usr/bin/ruby
# -*- encoding: utf-8 -*-

require './Board.rb'

endpoint = "http://ring:2048"

b = Board.new(endpoint)
r = Random.new(1234)

showGrid b.start

begin 
  1000.times do
    b.move(Direction::DIRS[r.rand(4)])
  end
rescue => err
  puts err
end

showGrid b.status
