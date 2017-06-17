class AddConcreteMembersToClans < ActiveRecord::Migration[5.0]
  def change
    add_column :clans, :concrete_members, :boolean, default: true
  end
end
