# frozen_string_literal: true
class CreateLanguages < ActiveRecord::Migration[5.0]
  def change
    create_table :languages do |t|
      t.string :code
      t.string :name
      t.string :nativename
      t.string :ipa
      t.references :lang_type, foreign_key: true
      t.string :phonosystem
      t.string :lexcols
      t.references :user, foreign_key: true
      t.text :overview
      t.boolean :public
      t.string :status
      t.boolean :prunesafe

      t.timestamps
    end
    add_index :languages, :code, unique: true
  end
end
