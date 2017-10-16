class AddCurrentLangToUsers < ActiveRecord::Migration[5.0]
  def change
    # Add reference to Language, named current_lang_id
    add_column :users, :current_lang_id, :integer, index: true
    add_foreign_key :users, :languages,
      column: 'current_lang_id', on_delete: :nullify
  end
end
