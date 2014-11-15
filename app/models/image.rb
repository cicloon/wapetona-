class Image < Asset

  has_attached_file :image, styles: {
    xsmall: "100x100>",
    small: "140x140>",
    medium: "200x200>",
    large: "300x300>",
    xlarge: "350x350>",
    xxlarge: "400x400>",
    xxxlarge: "420x420>"
  }

  validates_attachment :image, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }


end
