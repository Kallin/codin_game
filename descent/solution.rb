# https://www.codingame.com/training/easy/the-descent/solution

STDOUT.sync = true

loop do
  heights = []
  8.times do
    heights << gets.to_i
  end

  highest = heights.sort[-1]
  mountain_to_shoot = heights.index(highest)
  puts mountain_to_shoot
end