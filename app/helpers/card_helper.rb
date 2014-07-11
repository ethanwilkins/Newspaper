module CardHelper
  def card_image(image)
    image_tag(image, class: "card_image")
  end
end
