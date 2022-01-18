STDOUT.sync = true # DO NOT REMOVE
# Auto-generated code below aims at helping you parse
# the standard input according to the problem statement.

boosted = false
# game loop
loop do
  # next_checkpoint_x: x position of the next check point
  # next_checkpoint_y: y position of the next check point
  # next_checkpoint_dist: distance to the next checkpoint
  # next_checkpoint_angle: angle between your pod orientation and the direction of the next checkpoint
  x, y, next_checkpoint_x, next_checkpoint_y, next_checkpoint_dist, next_checkpoint_angle = gets.split(" ").collect { |x| x.to_i }
  opponent_x, opponent_y = gets.split(" ").collect { |x| x.to_i }

  # Write an action using puts
  # To debug: STDERR.puts "Debug messages..."

  # STDERR.puts "distance: #{next_checkpoint_dist}"

  # You have to output the target position
  # followed by the power (0 <= thrust <= 100)
  # i.e.: "x y thrust"
  if !boosted and (next_checkpoint_dist > 5000) and (next_checkpoint_angle < 10 and next_checkpoint_angle > -10 )
    boosted = true
    thrust = 'BOOST'
  else
    if next_checkpoint_angle > 90 or next_checkpoint_angle < -90
      thrust = 0
    else
      thrust = 100
    end
  end

  printf("#{next_checkpoint_x} #{next_checkpoint_y} #{thrust}\n")
end