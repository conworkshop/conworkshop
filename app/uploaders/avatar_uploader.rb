# frozen_string_literal: true

class AvatarUploader < ImageUploader
  process resize_to_fill: [112, 112]
end
