# frozen_string_literal: true

class CreateRouteAccessControls < ActiveRecord::Migration[5.0]
  def change
    create_table :route_access_controls do |t|
      t.string :route
      t.integer :level

      t.timestamps
    end

    add_index :route_access_controls, :route, unique: true
  end
end
