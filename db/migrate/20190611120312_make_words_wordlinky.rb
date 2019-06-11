class MakeWordsWordlinky < ActiveRecord::Migration[5.2]
  def change
    remove_column :words, :wlmeta
    add_column    :words, :gloss,     :string
    add_column    :words, :wordlinks, :string, array: true, default: []
    add_index     :words, :wordlinks, using: 'gin'
  end
end
