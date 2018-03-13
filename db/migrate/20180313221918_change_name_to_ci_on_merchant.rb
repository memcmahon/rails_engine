class ChangeNameToCiOnMerchant < ActiveRecord::Migration[5.1]
  enable_extension("citext")
  def change
    change_column :merchants, :name, :citext
  end
end
