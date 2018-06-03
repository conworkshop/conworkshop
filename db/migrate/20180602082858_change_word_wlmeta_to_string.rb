class ChangeWordWlmetaToString < ActiveRecord::Migration[5.2]
  def change
    remove_column :words, :wlmeta
    add_column :words, :wlmeta, :string
  end
end
