# https://www.codingame.com/training/easy/temperatures

n = gets.to_i
inputs = gets.split(" ").map {|it| it.to_i}

closest = 0
distance = nil
inputs.each do |temp|
  temp_distance = temp.abs
  if (distance == nil) || (distance > temp_distance)
    distance = temp_distance
    closest = temp
  end
  if (distance == temp_distance) && temp > 0
    closest = temp
  end
end

puts closest
