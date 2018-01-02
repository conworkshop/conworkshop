# frozen_string_literal: true

# noinspection RubyClassModuleNamingConvention
class ChangeDefaultForUserPreferences < ActiveRecord::Migration[5.0]
  def change
    change_column_default :users, :preferences, from: nil, to: '{}'
  end
end
