require 'csv'


task :import => [:environment] do
  
  Transaction.destroy_all
  InvoiceItem.destroy_all
  Item.destroy_all
  Invoice.destroy_all
  Merchant.destroy_all
  Customer.destroy_all

  CSV.foreach("db/data/customer.csv", :headers => true, header_converters: :symbol, converters: :numeric) do |row|
    Customer.create(row.to_hash)
  end

  puts "Created #{Customer.count} Customers"

  CSV.foreach("db/data/merchant.csv", :headers => true, header_converters: :symbol, converters: :numeric) do |row|
    Merchant.create(row.to_hash)
  end

  puts "Created #{Merchant.count} Merchants"

  CSV.foreach("db/data/invoice.csv", :headers => true, header_converters: :symbol, converters: :numeric) do |row|
    Invoice.create(row.to_hash)
  end

  puts "Created #{Invoice.count} Invoices"

  CSV.foreach("db/data/item.csv", :headers => true, header_converters: :symbol, converters: :numeric) do |row|
    Item.create(row.to_hash)
  end

  puts "Created #{Item.count} Items"

  CSV.foreach("db/data/invoice_item.csv", :headers => true, header_converters: :symbol, converters: :numeric) do |row|
    InvoiceItem.create(row.to_hash)
  end

  puts "Created #{InvoiceItem.count} InvoiceItems"

  CSV.foreach("db/data/transaction.csv", :headers => true, header_converters: :symbol, converters: :numeric) do |row|
    Transaction.create(id: row[:id],
                       invoice_id: row[:invoice_id],
                       credit_card_number: row[:credit_card_number],
                       result: row[:result],
                       created_at: row[:created_at],
                       updated_at: row[:updated_at])
  end

  puts "Created #{Transaction.count} Transactions"

end
