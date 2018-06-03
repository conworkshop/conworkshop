class AddWcToWords < ActiveRecord::Migration[5.2]
  def change
    add_column :words, :wc, :string
  end
end
