# frozen_string_literal: true

class ClanFormBuilder < ActionView::Helpers::FormBuilder
  def permission_select(method, _options = {})
    @template.select(@object_name, method, Clan::PERMISSION_TYPES.map { |c| [I18n.t("clans.permissions.#{c}"), c] })
  end
end
