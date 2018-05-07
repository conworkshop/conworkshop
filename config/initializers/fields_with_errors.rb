ActionView::Base.field_error_proc = Proc.new do |html_tag, instance|
  if html_tag =~ /<(input|textarea|select)/

    doc = Nokogiri::XML(html_tag)
    doc.children.each do |field|
      unless field['type'] == 'hidden'
        unless field['class'] =~ /\bis\\-invalid\b/
          field['class'] = "#{field['class']} is-invalid".strip
        end
      end
    end

    doc.to_html.html_safe
  else
    html_tag
  end
end