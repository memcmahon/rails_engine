class ChangeNamesToCiOnCustomers < ActiveRecord::Migration[5.1]
  enable_extension("citext")

  def change
    change_column :customers, :first_name, :citext
    change_column :customers, :last_name, :citext
  end
end
