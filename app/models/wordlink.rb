# frozen_string_literal: true

class Wordlink < ApplicationRecord
  validates :wlid, presence: true, uniqueness: true
  validates :wc, presence: true, inclusion: { in: Word::WORD_CLASS }

  before_validation :generate_uuid

  def to_param
    wlid
  end

  def self.search(term)
    where('english ILIKE :term OR american ILIKE :term', term: "#{term.downcase}%").order('english ASC')
  end

  private

  def generate_uuid
    begin
      self.wlid ||= SecureRandom.hex
    end while Wordlink.where(wlid: self.wlid).exists?
  end
end