# frozen_string_literal: true

class UserDefaultRank < ActiveRecord::Migration[5.0]
  def change
    change_column :users, :group, :string, default: 'R'
    User.update_all group: 'R'
    change_column_null :users, :group, false
  end
end
