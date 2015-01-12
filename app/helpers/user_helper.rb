module UserHelper
  def gallery_image(image)
    link_to image_tag(image.image, size: "60x60",
      id: :gallery_image), post_path(image)
  end
end
