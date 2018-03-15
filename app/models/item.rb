class Item < ApplicationRecord
  validates_presence_of :name, :description, :unit_price, :merchant_id
  belongs_to :merchant

  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  scope :find_by_attribute, ->(attribute) { find_by(attribute) }
  scope :find_all_by_attribute, ->(attribute) { where(attribute) }

  def self.random
    order("RANDOM()").first
  end

  def best_day
    invoices.select("invoices.*, SUM(invoice_items.quantity) AS total")
            .joins(:invoice_items)
            .group(:id)
            .order("total DESC")
            .first
            .created_at
  end

  def self.most_revenue(quantity)
    select("items.*, sum(invoice_items.quantity * invoice_items.unit_price) AS item_revenue")
    .joins(invoice_items: [invoice: :transactions])
    .merge(Transaction.successful)
    .group(:id)
    .order("item_revenue desc")
    .limit(quantity)
  end

  def self.ranked_by_sale(quantity)
    select("items.id, sum(invoice_items.quantity) AS total")
    .joins(:invoice_items, invoices: :transactions)
    .where(transactions: {result: "success"})
    .group(:id)
    .order("total DESC")
    .limit(quantity)
  end
end
