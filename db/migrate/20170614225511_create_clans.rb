class CreateClans < ActiveRecord::Migration[5.0]
  def change
    create_table :clans do |t|
      t.string :name
      t.text :description
      t.text :page_text
      t.string :colour
      t.string :symbol
      t.string :permission

      t.timestamps
    end
  end
end
