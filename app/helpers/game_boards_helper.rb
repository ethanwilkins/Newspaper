module GameBoardsHelper
  def card_shadow(card)
    if card.redeemed
      "color_game_card"
    else
      "bw_game_card"
    end
  end
end
