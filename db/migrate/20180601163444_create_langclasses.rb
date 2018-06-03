# frozen_string_literal: true

class CreateLangclasses < ActiveRecord::Migration[5.2]
  def change
    create_table :langclasses do |t|
      t.references :language, foreign_key: true
      t.string :name
      t.string :classcode
      t.string :wc
    end
  end
end
