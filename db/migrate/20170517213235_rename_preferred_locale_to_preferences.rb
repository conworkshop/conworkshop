# frozen_string_literal: true

# noinspection RubyClassModuleNamingConvention
class RenamePreferredLocaleToPreferences < ActiveRecord::Migration[5.0]
  def change
    rename_column :users, :preferred_locale, :preferences

    reversible do |dir|
      dir.up do
        change_column :users, :preferences, :text
      end

      dir.down do
        change_column :users, :preferences, :string
      end
    end
  end
end
