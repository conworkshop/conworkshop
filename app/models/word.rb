# frozen_string_literal: true

class Word < ApplicationRecord
  WORD_CLASS = %w[ABB ADJ ADP ADV AFF AUX C DET I N NUM PTC PHR P PPR V].freeze
  WORD_REG   = %w[N ARCH CASL DATD EUPH FORM HONR HUMB HMRS INTM JRGN POET RELG SLNG TBOO VULG OTHR].freeze

  belongs_to :language
  belongs_to :user

  validates :wid,  presence: true, uniqueness: true
  validates :user, presence: true

  validates :wc,       presence: true, inclusion: { in: WORD_CLASS }
  validates :register, inclusion: { in: WORD_REG }

  validates :wordlinks, presence: true
  validate :functional_wordlinks

  before_validation :generate_uuid
  before_save :update_wlmeta

  def to_param
    wid
  end

  private

  def update_wlmeta
    # TODO
    # Obtain the glosses for wordlinks and put them nicely into DB for quick access
    # Maybe need new column? (bring back wlmeta lol)
  end

  def generate_uuid
    unless self.wid
      begin
        self.wid ||= SecureRandom.hex
      end while Word.where(wid: self.wid).exists?
    end
  end

  def functional_wordlinks
    self.wordlinks.each do |wl|
      unless Wordlink.exists?(wlid: wl.wlid)
        errors.add(:wordlinks, 'could not be found')
        break
      end
    end
  end
end
