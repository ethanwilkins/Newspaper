module UserHelper
  def gallery_image(image)
    link_to image_tag(image.image, size: "75x75",
      id: :gallery_image), post_path(image)
  end
end
