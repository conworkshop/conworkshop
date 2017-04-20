# frozen_string_literal: true
# Taken from https://gist.github.com/iqbalhasnan/9621174 with small modifications
module CarrierWave
  module MiniMagick
    # Rotates the image based on the EXIF Orientation
    def exif_rotation
      manipulate! do |img|
        img.auto_orient
        img = yield(img) if block_given?
        img
      end
    end

    # Strips out all embedded information from the image
    def strip
      manipulate! do |img|
        img.strip
        img = yield(img) if block_given?
        img
      end
    end

    # Tiny gaussian blur to optimize the size
    def gaussian_blur(radius)
      manipulate! do |img|
        img.gaussian_blur(radius.to_s)
        img = yield(img) if block_given?
        img
      end
    end

    # set the Interlace of the image plane/basic
    # def interlace(type)
    #   manipulate! do |img|
    #     img.interlace(type.to_s)
    #     img = yield(img) if block_given?
    #     img
    #   end
    # end

    # Reduces the quality of the image to the percentage given
    # def quality(percentage)
    #   manipulate! do |img|
    #     img.quality(percentage.to_s)
    #     img = yield(img) if block_given?
    #     img
    #   end
    # end
  end
end
