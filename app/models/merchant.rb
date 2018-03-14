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
    .joins(invoices: [:invoice_items, :transactions])
    .where("transactions.result = 'success'")
    .group(:id)
    .order("revenue desc")
    .limit(quantity)
  end
end
