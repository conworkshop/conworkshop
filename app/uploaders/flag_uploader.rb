# frozen_string_literal: true

class FlagUploader < ImageUploader
  before :cache, :capture_size_before_cache

  process resize_to_fit: Language::FLAG_DIMENSIONS

  version :thumb do
    process resize_to_fit: Language::FLAG_THUMB_DIMENSIONS
  end

  private

  def capture_size_before_cache(file)
    unless model.flag_width || model.flag_height
      model.flag_width, model.flag_height = `identify -format "%wx %h" #{file.path.shellescape}`.split(/x/).map(&:to_i)
    end
  end
end
