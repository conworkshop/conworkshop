class CreateClanRequests < ActiveRecord::Migration[5.0]
  def change
    create_table :clan_requests do |t|
      t.references :user, foreign_key: true
      t.references :clan, foreign_key: true

      t.timestamps
    end
  end
end
