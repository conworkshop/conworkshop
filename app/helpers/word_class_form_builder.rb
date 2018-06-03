# frozen_string_literal: true

module ActionView
  module Helpers
    class FormBuilder
      def word_class_select(method, options = {}, html_options = {})
        @template.word_class_select(
            @object_name,
            method,
            objectify_options(options),
            @default_options.merge(html_options)
        )
      end
    end

    module FormOptionsHelper
      def word_class_select(object, method, options = {}, html_options = {})
        Tags::WordClassSelect.new(object, method, self, options, html_options).render
      end
    end

    module Tags
      class WordClassSelect < Base
        def initialize(object_name, method_name, template_object, options, html_options)
          @html_options = html_options

          super(object_name, method_name, template_object, options)
        end

        def render
          @options[:prompt] ||= I18n.t('words.classes.X')
          select_content_tag(word_class_option_tags, @options, @html_options)
        end

        private

        def word_class_option_tags
          @options[:selected] ||= @object.wc
          options_for_select(Word::WORD_CLASS.map { |c| [I18n.t("words.classes.#{c}"), c] }, @options)
        end
      end
    end
  end
end
