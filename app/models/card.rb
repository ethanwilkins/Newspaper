class Card < ActiveRecord::Base
  belongs_to :user
  belongs_to :code
  belongs_to :game_board
  
  @@board1 = [:soccerball, :shrimp, :dolphin, :elephant, :runner,
        :bigfoot, :bear, :umbrella, :submarine, :sailboat, :bottle,
        :swords, :star, :moon, :thumbs_up, :guitar]
  
  @@board2 = [:crocodile, :flamingo, :lion, :earth, :bird, :cake,
        :eagle, :flag, :bicycle, :lady, :lizard, :key,
        :butterfly, :wave, :frog, :mermaid]
  
  @@board3 = [:scorpian, :ring, :camel, :swordfish, :rooster,
        :cactus, :dog, :deer, :lightbulb, :karate, :phone,
        :jet, :flag, :moon, :candle, :motorcycle]
  
  @@board4 = [:tree, :owl, :crocodile, :lion, :dog, :sax,
        :eagle, :spider, :lady, :star, :palm_tree, :frog,
        :mermaid, :boot, :beard, :sunglasses]
        
  def self.unique_names
    boards = [@@board1, @@board2, @@board3, @@board4]
    unique = []
    for board in boards
      for card in board
        unique << card unless unique.any? { |_card| card == _card }
      end
    end
    return unique.sort
  end
  
  def self.names(board_num)
    case board_num
    when 1
      return @@board1
    when 2
      return @@board2
    when 3
      return @@board3
    when 4
      return @@board4
    end
  end
  
  def redeemed_img
    new_img = ""
    image.split('/').each do |string|
      unless string == "bw"
        if new_img.empty?
          new_img << string
        else
          new_img << "/" + string
        end
      else
        new_img << "/color"
      end
    end
    return new_img
  end
  
  def self.redeem(code, board_num)
    _code = Code.find_by_code(code)
    unless _code and _code.is_a_board
      _code if _code and self.names(board_num).include? _code.card_name.to_sym
    end
  end
end
