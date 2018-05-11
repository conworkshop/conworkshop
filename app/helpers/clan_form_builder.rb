# frozen_string_literal: true

# class ClanFormBuilder < ActionView::Helpers::FormBuilder
#   def permission_select(attrib, options = {}, html_options = {})
#     @template.select_tag(attrib, permission_options(options), html_options)
#   end
#
#   def permission_options(options)
#     options[:selected] ||= @object.permission if @object.permission.present?
#     @template.options_for_select(Clan::PERMISSION_TYPES.map { |c| [I18n.t("clans.permissions.#{c}"), c] })
#   end
# end

module ActionView
  module Helpers
    class FormBuilder
      def clan_perm_select(method, options = {}, html_options = {})
        @template.clan_perm_select(
            @object_name,
            method,
            objectify_options(options),
            @default_options.merge(html_options)
        )
      end
    end

    module FormOptionsHelper
      def clan_perm_select(object, method, options = {}, html_options = {})
        Tags::ClanPermSelect.new(object, method, self, options, html_options).render
      end
    end

    module Tags
      class ClanPermSelect < Base
        def initialize(object_name, method_name, template_object, options, html_options)
          @html_options = html_options

          super(object_name, method_name, template_object, options)
        end

        def render
          select_content_tag(clan_perm_option_tags, @options, @html_options)
        end

        private

        def clan_perm_option_tags
          @options[:selected] ||= @object.permission
          options_for_select(Clan::PERMISSION_TYPES.map { |c| [I18n.t("clans.permissions.#{c}"), c] }, @options)
        end
      end
    end
  end
end
