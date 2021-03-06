class Merchant < ApplicationRecord
  validates_presence_of :name

  has_many :invoices
  has_many :items

  scope :find_all_by_attribute, ->(attribute) { where(attribute) }
  scope :find_by_attribute, ->(attribute) { find_by(attribute) }

  def self.random_record
    order("RANDOM()").first
  end

  def self.rank_by_revenue(quantity)
    unscoped
    .select("merchants.*, sum(invoice_items.quantity * invoice_items.unit_price) AS merchant_revenue")
    .joins(invoices: [:invoice_items, :transactions])
    .merge(Transaction.successful)
    .group(:id)
    .order("merchant_revenue desc")
    .limit(quantity)
  end

  def revenue(date = {})
    invoices.select("sum(invoice_items.unit_price * invoice_items.quantity) AS revenue")
    .joins(:invoice_items, :transactions)
    .unscope(:order)
    .where("transactions.result = 'success'")
    .where(date)
    .group(:merchant_id)[0]
    .revenue
  end

  def self.ranked_by_item(limit)
    unscoped
    .select("merchants.*, sum(invoice_items.quantity) AS total")
    .joins(invoices: [:transactions, :invoice_items])
    .merge(Transaction.successful)
    .group(:id)
    .order("total DESC")
    .limit(limit)
  end
end
