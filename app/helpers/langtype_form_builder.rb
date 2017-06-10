# frozen_string_literal: true
module ActionView
  module Helpers
    class FormBuilder
      def langtype_select(method, options = {}, html_options = {})
        @template.langtype_select(
          @object_name,
          method,
          objectify_options(options),
          @default_options.merge(html_options)
        )
      end
    end

    module FormOptionsHelper
      def langtype_select(object, method, options = {}, html_options = {})
        Tags::LangtypeSelect.new(object, method, self, options, html_options).render
      end
    end

    module Tags
      class LangtypeSelect < Base
        def initialize(object_name, method_name, template_object, options, html_options)
          @html_options = html_options

          super(object_name, method_name, template_object, options)
        end

        def render
          select_content_tag(langtype_option_tags, @options, @html_options)
        end

        private

        def langtype_option_tags
          option_tags_options = {
            selected: @options.fetch(:selected) { value(@object) },
            disabled: @options[:disabled]
          }

          options_for_select(langtype_codes_for_options, option_tags_options)
        end

        def langtype_codes
          Rails.cache.fetch('langtype_codes') do
            LangType.all.select(:code)
          end
        end

        def langtype_codes_for_options
          langtype_codes.map { |c| [I18n.t(c.code, scope: %w(general langtype)), c.code] }
        end
      end
    end
  end
end
