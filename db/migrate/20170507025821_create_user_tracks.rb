class CreateUserTracks < ActiveRecord::Migration[5.0]
  def change
    create_table :user_tracks do |t|
      t.references :user, foreign_key: true
      t.datetime :tracked_at
      t.string :route
    end
  end
end
