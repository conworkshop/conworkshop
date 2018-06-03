class RenameClassToWcInWordlinks < ActiveRecord::Migration[5.2]
  def change
    rename_column :wordlinks, :class, :wc
  end
end
