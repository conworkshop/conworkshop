class CreatePhones < ActiveRecord::Migration[5.2]
  def change
    create_table :phones do |t|
      t.string :code
      t.string :name
      t.string :col
      t.string :row
      t.string :articulation
      t.boolean :voiceless
      t.string :ipa
      t.string :sampa

      t.timestamps
    end
    add_index :phones, :code, unique: true
  end
end
