class Invoice < ApplicationRecord
  validates_presence_of :customer_id, :merchant_id, :status
  belongs_to :customer
  belongs_to :merchant
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :transactions

  scope :find_by_attribute, ->(attribute) { find_by(attribute) }
  scope :find_all_by_attribute, ->(attribute) { where(attribute) }

  def self.random
    order("RANDOM()").first
  end

  def self.revenue_by_date(date)
    joins(:invoice_items, :transactions)
    .merge(Transaction.successful)
    .where(created_at: date.beginning_of_day..date.end_of_day)
    .sum("invoice_items.unit_price * invoice_items.quantity") / 100.0
  end
end
