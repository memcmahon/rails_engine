class ChangeNameToCiOnItem < ActiveRecord::Migration[5.1]
  enable_extension("citext")
  def change
    change_column :items, :name, :citext
    change_column :items, :description, :citext
  end
end
