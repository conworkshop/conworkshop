class AddDetailsToUsers < ActiveRecord::Migration[5.0]
  def change
    change_table :users do |t|
      t.string  :username, null: false, limit: 24, default: ''
      t.string  :alias
      t.string  :timezone
      t.integer :group
      t.integer :flags
      t.integer :auth_type, null: false, default: 1
    end

    add_index :users, :username, unique: true
  end
end
