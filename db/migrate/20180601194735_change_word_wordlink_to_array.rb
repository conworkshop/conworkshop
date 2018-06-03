class ChangeWordWordlinkToArray < ActiveRecord::Migration[5.2]
  def change
    remove_column :words, :wordlink_id
    remove_column :words, :wlmeta
    add_column :words, :wordlink_id, :bigint, array: true, default: []
    add_column :words, :wlmeta, :string, array: true, default: []
  end
end
