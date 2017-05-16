class AddPreferredLocaleToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :preferred_locale, :string, default: 'en'
  end
end
