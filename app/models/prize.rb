class Prize < ActiveRecord::Base
  
  # available prize types will be set by group, when a user wins a prize,
  # a prize of correct type will be assigned to the user, not created

  belongs_to :group
  belongs_to :user
  
  def self.available?(group, user, combo_type)
    if group.prizes.where(combo_type: combo_type).present? and \
      user.prizes.where(combo_type: combo_type).empty?
      return true
    end
  end
  
  def self.get_combo_type(winning_combo)
    case winning_combo
    when :fc1, :fc2, :fc3, :fc4
      combo_type = "first_corner"
    when :s5
      combo_type = "first_center"
    when :l1
      combo_type = "four_corners"
    when :h1, :h2, :h3, :h4, :v1, :v2, :v3, :v4, :d1, :d2
      combo_type = "line_of_four"
    when :f1
      combo_type = "full_board"
    end
    return combo_type
  end
  
  def self.wins
    # a hash containing all possible winning combinations, the key of your winning combo gets saved
    { s1: [1, 2, 5, 6],   s2: [2, 3, 6, 7],    s3: [3, 4, 7, 8],     s4: [5, 6, 9, 10], s5: [6, 7, 10, 11], # small squares
      s6: [7, 8, 11, 12], s7: [9, 10, 13, 14], s8: [10, 11, 14, 15], s9: [11, 12, 15, 16], # small squares
      h1: [1, 2, 3, 4],   h2: [5, 6, 7, 8],    h3: [9, 10, 11, 12],  h4: [13, 14, 15, 16], # horizontal lines
      v1: [1, 5, 9, 13],  v2: [2, 6, 10, 14],  v3: [3, 7, 11, 15],   v4: [4, 8, 12, 16], # vertical lines
      f1: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16], # full board
      fc1: [1], fc2: [4], fc3: [13], fc4: [16], # first corners
      d1:[1, 6, 11, 16], d2: [4, 7, 10, 13], # diagonal
      l1: [1, 4, 13, 16] } # large square
  end
end
