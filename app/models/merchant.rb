class Merchant < ApplicationRecord
  validates_presence_of :name

  has_many :invoices
  has_many :items

  scope :find_all_by_attribute, ->(attribute) { where(attribute) }
  scope :find_by_attribute, ->(attribute) { find_by(attribute) }

  def self.random_record
    all.sample(1)[0]
  end

  def self.rank_by_revenue(quantity)
    select("merchants.*, sum(invoice_items.quantity * invoice_items.unit_price) AS revenue")
    .joins(invoices: :invoice_items)
    .joins(invoices: :transactions)
    .where("transactions.result = 'success'")
    .group(:id)
    .order("revenue desc")
  end
end

#SQL: SELECT merchants.*, sum(invoice_items.quantity * invoice_items.unit_price) AS revenue
      #FROM merchants
      #JOIN invoices ON invoices.merchant_id = merchants.id
      #JOIN invoice_items ON invoice_items.invoice_id = invoices.id
      #JOIN items ON invoice_items.item_id = items.id
      #JOIN transactions ON transactions.invoice_id = invoices.id
      #WHERE transaction.result = "success"
      #GROUP BY merchants.id
      #ORDER BY revenue
      #LIMIT #{quantity}
