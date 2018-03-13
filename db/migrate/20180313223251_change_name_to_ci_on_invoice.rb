class ChangeNameToCiOnInvoice < ActiveRecord::Migration[5.1]
  enable_extension("citext")
  def change
    change_column :invoices, :status, :citext
  end
end
