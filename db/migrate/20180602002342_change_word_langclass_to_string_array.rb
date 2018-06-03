class ChangeWordLangclassToStringArray < ActiveRecord::Migration[5.2]
  def change
    remove_column :words, :langclass_id
    add_column :words, :langclass, :string, array: true, default: []
  end
end
