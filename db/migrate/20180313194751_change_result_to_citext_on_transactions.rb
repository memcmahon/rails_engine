class ChangeResultToCitextOnTransactions < ActiveRecord::Migration[5.1]
  enable_extension("citext")

  def change
    change_column :transactions, :result, :citext
  end
end
