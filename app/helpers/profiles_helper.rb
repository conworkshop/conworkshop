# frozen_string_literal: true

module ProfilesHelper
  # Yields a list of languages for the given user to the given block.
  # Only these fields are available: code, name, nativename, flag
  #
  # @param [User] user
  # @yieldparam [Language] language the yielded language
  def lang_list(user, &block)
    Language.languages_selecting(user, :code, :name, :nativename, :flag).each(&block)
  end
end
