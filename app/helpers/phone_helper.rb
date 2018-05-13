# frozen_string_literal: true

module PhoneHelper
  def articulation_select_options(selected = nil)
    phone_attr_options Phone::ARTICULATIONS, 'phones.articulations', selected
  end

  def place_select_options(selected = nil)
    phone_attr_options Phone::CONS_PLACE, 'phones.place', selected
  end

  def manner_select_options(selected = nil)
    phone_attr_options Phone::CONS_MANNER, 'phones.manner', selected
  end

  def back_select_options(selected = nil)
    phone_attr_options Phone::VOWEL_BACK, 'phones.back', selected
  end

  def height_select_options(selected = nil)
    phone_attr_options Phone::VOWEL_HEIGHT, 'phones.height', selected
  end

  def phone_attr_options(source, scope, selected = nil)
    ret = Hash.new
    source.each do |art|
      ret["#{t(art, scope: scope)} (#{art})"] = art
    end
    options_for_select(ret, selected)
  end
end