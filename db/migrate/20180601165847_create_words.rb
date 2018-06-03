class CreateWords < ActiveRecord::Migration[5.2]
  def change
    create_table :words do |t|
      t.string :wid
      t.references :language, foreign_key: true
      t.references :user, foreign_key: true
      t.string :head
      t.references :wordlink, foreign_key: true
      t.string :wlmeta
      t.string :althead
      t.references :langclass
      t.string :register
      t.string :sampa
      t.string :ipa
      t.text :etym
      t.text :notes
      t.text :sample
      t.text :imgurl
      t.string :sourcelang

      t.timestamps
    end
    add_index :words, :wid, unique: true
  end
end
