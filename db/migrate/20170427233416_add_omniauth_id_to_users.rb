# frozen_string_literal: true

class AddOmniauthIdToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :oaid, :string
    add_index :users, :oaid
  end
end
