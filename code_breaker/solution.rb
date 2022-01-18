# https://www.codingame.com/training/easy/code-breaker-puzzle

# Auto-generated code below aims at helping you parse
# the standard input according to the problem statement.

alphabet = gets.chomp
message = gets.chomp
word = gets.chomp

# Write an answer using puts
# To debug: STDERR.puts "Debug messages..."
STDERR.puts 'testing'
STDERR.puts "Alphabet: #{alphabet}"
STDERR.puts "Message: #{message}"
STDERR.puts "Word: #{word}"

alphabet_chars = alphabet.split ""
a_test = 0
b_test = 1
found = false
decrypted_message = "unknown"
while !found

  STDERR.puts "TESTING A:#{a_test} B:#{b_test}"

  if (b_test > alphabet.length)
    raise 'failure to find solution'
  end

  scramble_map = {}
  new_alpha_indexes = []
  alphabet_chars.length.times { |i| new_alpha_indexes[i] = (((i + a_test) * b_test) % alphabet.length) }
  scrambled_alpha = new_alpha_indexes.map { |i| alphabet_chars[i] }
  alphabet_chars.each_with_index { |letter, index| scramble_map[letter] = scrambled_alpha[index] }

  scrambled = word.split("").map do |word_char|
    scramble_map[word_char]
  end.join("")

  if message.include? scrambled
    descramble_map = scramble_map.invert
    decrypted_message = message.split("").map { |letter| descramble_map[letter] }.join
    found = true
  else
    a_test += 1
    if a_test > alphabet.length
      a_test = 0
      b_test += 1
    end
  end
end

puts decrypted_message