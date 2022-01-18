base_state = [
  { :index => 0, :richness => 3 },
  { :index => 1, :richness => 3 },
  { :index => 2, :richness => 3 },
  { :index => 3, :richness => 3 },
  { :index => 4, :richness => 3 },
  { :index => 5, :richness => 3 },
  { :index => 6, :richness => 3 },
  { :index => 7, :richness => 2 },
  { :index => 8, :richness => 2, :tree_size => 1, :is_dormant => false, :owner => "P1" },
  { :index => 9, :richness => 2 },
  { :index => 10, :richness => 2 },
  { :index => 11, :richness => 2, :tree_size => 1, :is_dormant => false, :owner => "P1" },
  { :index => 12, :richness => 2 },
  { :index => 13, :richness => 2 },
  { :index => 14, :richness => 2, :tree_size => 1, :is_dormant => false, :owner => "P2" },
  { :index => 15, :richness => 2 },
  { :index => 16, :richness => 2 },
  { :index => 17, :richness => 2, :tree_size => 2, :is_dormant => false, :owner => "P2" },
  { :index => 18, :richness => 2 },
  { :index => 19, :richness => 1 },
  { :index => 20, :richness => 1 },
  { :index => 21, :richness => 1 },
  { :index => 22, :richness => 1, :tree_size => 1, :is_dormant => false, :owner => "P2" },
  { :index => 23, :richness => 1 },
  { :index => 24, :richness => 1 },
  { :index => 25, :richness => 1 },
  { :index => 26, :richness => 1 },
  { :index => 27, :richness => 1, :tree_size => 1, :is_dormant => false, :owner => "P2" },
  { :index => 28, :richness => 1 },
  { :index => 29, :richness => 1 },
  { :index => 30, :richness => 1 },
  { :index => 31, :richness => 1, :tree_size => 1, :is_dormant => false, :owner => "P1" },
  { :index => 32, :richness => 1 },
  { :index => 33, :richness => 1 },
  { :index => 34, :richness => 1 },
  { :index => 35, :richness => 1 },
  { :index => 36, :richness => 1, :tree_size => 1, :is_dormant => false, :owner => "P1" },

]
#
# STDOUT.sync = true # DO NOT REMOVE
# # Auto-generated code below aims at helping you parse
# # the standard input according to the problem statement.
#
# number_of_cells = gets.to_i # 37
#
# board = []
# number_of_cells.times do
#   index, richness, neigh_0, neigh_1, neigh_2, neigh_3, neigh_4, neigh_5 = gets.split(" ").collect { |x| x.to_i }
#   board << { index: index, richness: richness }
# end

class Game

  # def initialize(board, trees, p1_sun, p1_score, p2_sun, p2_score, day, curr_player = 'P1')
  #   @cells = board.map do |cell|
  #     tree = trees.find { |tree| tree[:cell_index] == cell[:index] }
  #     unless tree.nil?
  #       cell[:tree_size] = tree[:size]
  #       cell[:is_dormant] = tree[:is_dormant]
  #       cell[:owner] = tree[:is_mine] ? 'P1' : 'P2'
  #     end
  #
  #     cell
  #   end
  #
  #   @p1_sun = p1_sun
  #   @p1_score = p1_score
  #   @p2_sun = p2_sun
  #   @p2_score = p2_score
  #   @day = day
  #   @curr_player = curr_player
  # end

  def initialize(cells, p1_sun, p1_score, p2_sun, p2_score, day, curr_player = 'P1', p1_is_waiting = false, p2_is_waiting = false)
    @cells = cells
    @p1_sun = p1_sun
    @p1_score = p1_score
    @p2_sun = p2_sun
    @p2_score = p2_score
    @day = day
    @curr_player = curr_player
    @p1_is_waiting = p1_is_waiting
    @p2_is_waiting = p2_is_waiting
  end

  def render
    STDERR.puts "day: #{@day}, curr_player: #{@curr_player}"
    STDERR.puts "p1 sun: #{@p1_sun}, p1 score: #{@p1_score}"
    STDERR.puts "p2 sun: #{@p2_sun}, p2 score: #{@p2_score}"
    STDERR.puts @cells
  end

  def best_move_basic
    curr_player_cells = @cells.select { |cell| cell[:owner] == @curr_player }
    best_cell = curr_player_cells.max_by { |cell| cell[:richness] }
    "COMPLETE #{best_cell[:index]}"
  end

  def gen_moves
    #  let's gen all completes
    # #  then gen all grows
    #   #  then gen the wait
    moves = []
    if @curr_player == 'P1'
      my_active_cells = @cells.select {|cell| cell[:owner] =='P1' && !cell[:is_dormant]}

    else
      my_active_cells = @cells.select {|cell| cell[:owner] =='P2' && !cell[:is_dormant]}
      my_active_cells.each do |cell|
        if cell[]
        end
      end
    end

    class CompletionMove

    end

    def mini_max(depth, alpha, beta, maximizing_player)

      both_waiting = (@p1_is_waiting and @p2_is_waiting)
      #if both waiting, it's not a terminal state, just end of the day.
      if (depth == 0) || (@day == 7)
        #  terminal state, return the value
        if maximizing_player
          return @p1_score + (@p1_sun / 3)
        else
          return (@p2_score + (@p2_sun / 3)) * -1
        end
      end

      moves = gen_moves
      moves.each { |move| move.render }

      # The game is played over several rounds called days. Each day can be made up of several game turns. On each turn, both players perform one action simultaneously.
      # At the start of each day, players receive sun points.
      #   Then, players take actions by spending their sun points.
      #   The day ends when both players stop taking actions.
      #
      # players have 6 days to play.
      #

      #  generate all possible moves, then generate the child states for each one
      #
      # moves are:
      # GROW #{index}
      # command a seed or tree to grow to next size. max size is 3
      # Growing a size 1 tree into a size 2 tree costs 3 sun points + the number of size 2 trees you already own.
      # Growing a size 2 tree into a size 3 tree costs 7 sun points + the number of size 3 trees you already own.
      #
      #
      #
      # COMPLETE #{index}
      # scores points, removes tree
      # Completing a tree's lifecycle requires 4 sun points.
      # You can only complete the lifecycle of a size 3 tree.
      # Completing a tree's lifecycle will award you with as many points as the current nutrient value + a bonus according to the richness of the cell:
      # 1: +0 points.
      # 2: +2 points.
      # 3: +4 points.
      # Then, the nutrient value is decreased permanently by 1.
      #
      # WAIT
      #
      # Players gain an extra 1 point for every 3 sun points they have at the end of the game.
      #
      # #at start of turn, harvest sun points from each incomplete tree..
      # 1 pt for size 2, 2 for 2, 3 for 3

      #loop through all possible moves
      # generate sub-state
      # then recurse this function for opponent
      #
      # finally return the move that we want to execute..

    end

    # example python minmax for tictactoe..
    # def min(self):
    #
    #   # Possible values for minv are:
    #   # -1 - win
    #   # 0  - a tie
    #   # 1  - loss
    #
    #   # We're initially setting it to 2 as worse than the worst case:
    #   minv = 2
    #
    # qx = None
    # qy = None
    #
    # result = self.is_end()
    #
    # if result == 'X':
    #   return (-1, 0, 0)
    # elif result == 'O':
    #   return (1, 0, 0)
    # elif result == '.':
    #   return (0, 0, 0)
    #
    # for i in range(0, 3):
    #   for j in range(0, 3):
    #     if self.current_state[i][j] == '.':
    #       self.current_state[i][j] = 'X'
    #     (m, max_i, max_j) = self.max()
    #     if m < minv:
    #       minv = m
    #     qx = i
    #     qy = j
    #     self.current_state[i][j] = '.'
    #
    #     return (minv, qx, qy)

  end

  # # game loop
  # loop do
  #   day = gets.to_i # the game lasts 24 days: 0-23
  #   nutrients = gets.to_i # the base score you gain from the next COMPLETE action
  #   sun, score = gets.split(" ").collect { |x| x.to_i }
  #   opp_sun, opp_score, opp_is_waiting = gets.split(" ")
  #   opp_sun = opp_sun.to_i
  #   opp_score = opp_score.to_i
  #   opp_is_waiting = opp_is_waiting.to_i == 1
  #
  #   number_of_trees = gets.to_i # the current amount of trees
  #
  #   trees = []
  #   number_of_trees.times do
  #     cell_index, size, is_mine, is_dormant = gets.split(" ")
  #     cell_index = cell_index.to_i
  #     size = size.to_i
  #     is_mine = is_mine.to_i == 1
  #     is_dormant = is_dormant.to_i == 1
  #     trees << { cell_index: cell_index, size: size, is_mine: is_mine, is_dormant: is_dormant }
  #   end
  #
  #   number_of_possible_actions = gets.to_i # all legal actions
  #   possible_actions = []
  #   number_of_possible_actions.times do
  #     possible_action = gets.chomp # try printing something from here to start with
  #     possible_actions << possible_action
  #   end
  #
  #   game = Game.new(board, trees, sun, score, opp_sun, opp_score, day)
  #   game.render
  #   puts game.best_move
  # end
  #
  # def initialize(cells, p1_sun, p1_score, p2_sun, p2_score, day, curr_player = 'P1')
  game = Game.new(base_state, 4, 0, 4, 0, 0, 'P1')
  game.render