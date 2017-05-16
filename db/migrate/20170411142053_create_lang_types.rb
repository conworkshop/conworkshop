# frozen_string_literal: true
class CreateLangTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :lang_types do |t|
      t.string :code
      t.string :name

      t.timestamps
    end
    add_index :lang_types, :code
  end
end
