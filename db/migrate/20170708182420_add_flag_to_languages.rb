class AddFlagToLanguages < ActiveRecord::Migration[5.0]
  def change
    add_column :languages, :flag, :string,
      comment: "This is here and not in the flag table for easier access to the URL -- it's used everywhere."
  end
end
