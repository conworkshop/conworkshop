# frozen_string_literal: true

class Phone < ApplicationRecord
  CONS_PLACE   = %w[B L D A P R Y J W V U H X G I].freeze
  CONS_MANNER  = %w[N P I J Q F Z X R T L A C].freeze

  VOWEL_BACK   = %w[F N C K B].freeze
  VOWEL_HEIGHT = %w[C N L M I P O].freeze

  ALL_COLS = (CONS_PLACE + VOWEL_BACK).freeze
  ALL_ROWS = (CONS_MANNER + VOWEL_HEIGHT).freeze

  ARTICULATIONS = %w[C V].freeze

  validates :code,         presence: true, uniqueness: true
  validates :col,          presence: true, inclusion: { in: ALL_COLS }
  validates :row,          presence: true, inclusion: { in: ALL_ROWS }
  validates :articulation, presence: true, inclusion: { in: ARTICULATIONS }

  def to_param
    code
  end
end
