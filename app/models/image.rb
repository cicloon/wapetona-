class Image < Asset

  has_attached_file :image, styles: {thumb: "100x100#"}
  
  validates_attachment :image, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }


end
