class AddRoundednessToPhones < ActiveRecord::Migration[5.2]
  def change
    add_column :phones, :rounded, :boolean
  end
end
