# frozen_string_literal: true

class AvatarUploader < ImageUploader
  process resize_to_fill: [50, 50]
end
