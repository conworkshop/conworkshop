class ChangeWordsWordlinkToStringArray < ActiveRecord::Migration[5.2]
  def change
    remove_column :words, :wordlink_id
    add_column :words, :wordlinks, :string, array: true, default: []
  end
end
