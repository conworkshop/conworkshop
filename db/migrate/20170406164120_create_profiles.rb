# frozen_string_literal: true

class CreateProfiles < ActiveRecord::Migration[5.0]
  def change
    create_table :profiles do |t|
      t.references :user, foreign_key: true
      t.string :gender
      t.string :country
      t.text :about
      t.string :avatar
      t.string :language

      t.timestamps
    end
  end
end
