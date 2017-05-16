# frozen_string_literal: true

# Default uploader for everything - make sure to inherit from this
class ImageUploader < CarrierWave::Uploader::Base
  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  storage :file

  # Strip EXIF always.
  process :exif_rotation
  process :strip

  # Set gaussian blur to optimize the image
  process gaussian_blur: 0.05

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_whitelist
    %w(jpg jpeg gif png)
  end
end
