# frozen_string_literal: true
module ActionView
  module Helpers
    class FormBuilder
      def gender_select(method, options = {}, html_options = {})
        @template.gender_select(
          @object_name,
          method,
          objectify_options(options),
          @default_options.merge(html_options)
        )
      end
    end

    module FormOptionsHelper
      def gender_select(object, method, options = {}, html_options = {})
        Tags::GenderSelect.new(object, method, self, options, html_options).render
      end
    end

    module Tags
      class GenderSelect < Base
        def initialize(object_name, method_name, template_object, options, html_options)
          @html_options = html_options

          super(object_name, method_name, template_object, options)
        end

        def render
          select_content_tag(gender_option_tags, @options, @html_options)
        end

        def gender_option_tags
          option_tags_options = {
            selected: @options.fetch(:selected) { value(@object) },
            disabled: @options[:disabled]
          }

          options_for_select(gender_codes, option_tags_options)
        end

        def gender_codes
          @gender_codes_formatted ||= CWS::Globals::GENDER_CODES.invert.to_a
        end
      end
    end
  end
end
