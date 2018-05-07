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

        private

        def gender_option_tags
          options_for_select(gender_codes_for_options, @options)
        end

        def gender_codes
          CWS::Globals::GENDER_CODES
        end

        def gender_codes_for_options
          gender_codes.map { |c| [I18n.t(c, scope: %w[general gender]), c] }
        end
      end
    end
  end
end
