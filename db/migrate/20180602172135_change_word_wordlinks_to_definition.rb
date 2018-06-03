class ChangeWordWordlinksToDefinition < ActiveRecord::Migration[5.2]
  def change
    remove_column :words, :wordlinks
    create_table :definitions do |t|
      t.references :word, foreign_key: true
      t.string :wordlinks, array: true, default: []
      t.string :register

      t.timestamps
    end
  end
end
