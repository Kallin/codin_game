# https://www.codingame.com/training/easy/power-of-thor-episode-1

STDOUT.sync = true # DO NOT REMOVE

def generate_moves(delta_x, delta_y, diag_move)
  y_move, x_move = diag_move.split("")

  moves = []

  diagonals = [delta_x, delta_y].max - (delta_x - delta_y).abs
  diagonals.times { moves << diag_move }

  xy_delta = delta_x - delta_y
  if xy_delta >= 0
    xy_delta.times { moves << x_move }
  else
    xy_delta.abs.times { moves << y_move }
  end

  moves
end

light_x, light_y, initial_tx, initial_ty = gets.split(" ").collect { |x| x.to_i }

delta_x = light_x - initial_tx
delta_y = light_y - initial_ty

if (delta_x >= 0) and (delta_y >= 0)
  move_label = 'SE'
elsif (delta_x >= 0) and (delta_y < 0)
  move_label = 'NE'
elsif (delta_x < 0) and (delta_y >= 0)
  move_label = 'SW'
else
  move_label = 'NW'
end

moves = generate_moves(delta_x.abs, delta_y.abs, move_label)

loop do
  gets.to_i # can be ignored

  puts moves.shift
end