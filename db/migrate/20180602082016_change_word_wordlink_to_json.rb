class ChangeWordWordlinkToJson < ActiveRecord::Migration[5.2]
  def change
    remove_column :words, :wordlinks
    add_column :words, :wordlinks, :jsonb
  end
end
