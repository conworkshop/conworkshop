# frozen_string_literal: true

module ViewHelper
  def left_col(options={}, &block)
    options = options.reverse_merge(class: '', width: 3, padding: 'p-4')
    raw tag.div capture(&block), class: "col-xs-12 col-md-#{options[:width]}"\
                                                 " #{options[:padding]} #{options[:class]}"
  end

  def right_col(options={}, &block)
    options = options.reverse_merge(class: '', width: 9, padding: 'p-4')
    raw tag.div capture(&block), class: "col-xs-12 col-md-#{options[:width]}"\
                                                 " #{options[:padding]} #{options[:class]}"
  end

  def full_width(options={}, &block)
    options = options.reverse_merge(class: '', padding: 'p-4')
    raw tag.div capture(&block), class: "col-12 #{options[:padding]} #{options[:class]}"
  end
end