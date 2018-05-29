class CreateWordlinks < ActiveRecord::Migration[5.2]
  def change
    create_table :wordlinks do |t|
      t.string :wlid
      t.string :english
      t.string :american
      t.string :class
      t.string :hint
      t.text :notes
      t.text :locale
      t.references :user
      t.boolean :locked
      t.integer :count
      t.references :last_update_user

      t.timestamps
    end

    add_index :wordlinks, :wlid, unique: true
  end
end
