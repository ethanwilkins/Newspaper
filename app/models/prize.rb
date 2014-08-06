class Prize < ActiveRecord::Base
  belongs_to :user
  
  def self.wins
    # a hash containing all possible winning combinations, the key of your winning combo gets saved
    { h1: [1, 2, 3, 4],   h2: [5, 6, 7, 8],    h3: [9, 10, 11, 12],  h4: [13, 14, 15, 16], # horizontal lines
      v1: [1, 5, 9, 13],  v2: [2, 6, 10, 14],  v3: [3, 7, 11, 15],   v4: [4, 8, 12, 16], # vertical lines
      s1: [1, 2, 5, 6],   s2: [2, 3, 6, 7],    s3: [3, 4, 7, 8],     s4: [5, 6, 9, 10], s5: [6, 7, 10, 11], # small squares
      s6: [7, 8, 11, 12], s7: [9, 10, 13, 14], s8: [10, 11, 14, 15], s9: [11, 12, 15, 16], # small squares
      l1: [1, 4, 13, 16] } # large square
  end
end
