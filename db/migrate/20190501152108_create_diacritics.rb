class CreateDiacritics < ActiveRecord::Migration[5.2]
  def change
    create_table :diacritics do |t|
      t.string :ipa
      t.string :sampa
      t.string :name
      t.boolean :modifier

      t.timestamps
    end
    add_index :diacritics, :name, unique: true
  end
end
