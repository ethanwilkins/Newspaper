class Card < ActiveRecord::Base
  belongs_to :user
  belongs_to :code
  belongs_to :game_board
  
  @@board1 = [:balon, :camaron, :delfin, :elefante, :hombre, :mono,
    :oso, :paraguas, :submarino, :barco, :botella, :espada,
    :estrella, :luna, :mano, :guitarra]
  
  @@board2 = [:caiman, :flamenco, :leon, :mundo, :pajaro, :pastel,
    :aguila, :bandera, :bicicleta, :dama, :lagartija, :llave,
    :mariposa, :ola, :rana, :sirena]
  
  @@board3 = [:alacran, :anillo, :camello, :espadarte, :gallo,
    :nopal, :perro, :venado, :foco, :karate, :telephono,
    :avion, :bandera, :luna, :vela, :moto]
  
  @@board4 = [:arbol, :buho, :caiman, :leon, :perro, :sax,
    :aguila, :dama, :estrella, :palmera, :rana, :sirena,
    :bota, :barba, :lentes]
  
  def self.get_name(_image)
    for _name in Card.unique_names
      if _image.downcase.include? _name.to_s
        return _name
      end
    end
  end
        
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
