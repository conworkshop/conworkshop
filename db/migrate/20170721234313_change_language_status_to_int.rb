class ChangeLanguageStatusToInt < ActiveRecord::Migration[5.0]
  def up
    change_column :languages, :status, 'integer USING status::integer', default: 0
  end

  def down
    change_column :languages, :status, :string
  end
end
