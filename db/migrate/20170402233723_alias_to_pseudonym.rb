class AliasToPseudonym < ActiveRecord::Migration[5.0]
  def change
    rename_column :users, :alias, :pseudonym
  end
end
