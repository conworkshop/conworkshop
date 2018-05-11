# frozen_string_literal: true

class ClanFormBuilder < ActionView::Helpers::FormBuilder
  def permission_select(attrib, options = {}, html_options = {})
    @template.select_tag(attrib, permission_options(options), html_options)
  end

  def permission_options(options)
    options[:selected] ||= @object.permission if @object.permission.present?
    @template.options_for_select(Clan::PERMISSION_TYPES.map { |c| [I18n.t("clans.permissions.#{c}"), c] })
  end
end
