# frozen_string_literal: true
# temp place to put constants

module CWS
  module Globals
    GENDER_CODES = { 'M' => 'Male', 'F' => 'Female', 'O' => 'Other', 'C' => 'Cyborg' }.freeze

    def self.gender_codes
      GENDER_CODES
    end
  end
end
