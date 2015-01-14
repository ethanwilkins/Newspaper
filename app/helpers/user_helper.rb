module UserHelper
  def gallery_image(image)
    if defined? image.post_id
      post_id = image.post_id
    else
      post_id = image.id
    end
    
    link_to image_tag(image.image, size: "60x60",
      id: :gallery_image), post_path(post_id)
  end
end
