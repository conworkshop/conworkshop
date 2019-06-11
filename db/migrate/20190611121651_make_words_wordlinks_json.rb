class MakeWordsWordlinksJson < ActiveRecord::Migration[5.2]
  def change
    remove_column :words, :wordlinks
    remove_column :words, :register
    add_column    :words, :wordlinks, :jsonb, null: false, default: '{}'
    add_index     :words, :wordlinks, using: :gin
  end
end
