# frozen_string_literal: true

class AddDefaultClanToUsers < ActiveRecord::Migration[5.0]
  def change
    add_reference :users, :default_clan, foreign_key: true
  end
end
