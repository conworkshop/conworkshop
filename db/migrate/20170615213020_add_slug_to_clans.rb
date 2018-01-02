# frozen_string_literal: true

class AddSlugToClans < ActiveRecord::Migration[5.0]
  def change
    add_column :clans, :slug, :string
    add_index :clans, :slug
  end
end
