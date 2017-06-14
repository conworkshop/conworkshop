class CreateClanMemberships < ActiveRecord::Migration[5.0]
  def change
    create_table :clan_memberships do |t|
      t.references :user, foreign_key: true
      t.references :clan, foreign_key: true
      t.string :role

      t.timestamps
    end
  end
end
