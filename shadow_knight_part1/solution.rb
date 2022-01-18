# https://www.codingame.com/training/medium/shadows-of-the-knight-episode-1

STDOUT.sync = true # DO NOT REMOVE

w, h = gets.split(" ").collect { |x| x.to_i }
n = gets.to_i
x0, y0 = gets.split(" ").collect { |x| x.to_i }

x_min, y_min = 0, 0
x_max, y_max = (w - 1), (h - 1)
curr_x, curr_y = x0, y0

loop do
  bomb_dir = gets.chomp

  if bomb_dir.include? 'U'
    y_max = (curr_y - 1)
  end
  if bomb_dir.include? 'D'
    y_min = (curr_y + 1)
  end
  if bomb_dir.include? 'L'
    x_max = (curr_x - 1)
  end
  if bomb_dir.include? 'R'
    x_min = (curr_x + 1)
  end

  curr_x = (x_max + x_min) / 2
  curr_y = (y_max + y_min) / 2

  puts "#{curr_x} #{curr_y}"
end