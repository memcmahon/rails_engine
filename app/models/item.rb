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
    invoice_items.select('invoices.created_at, SUM(invoice_items.quantity) AS total')
                 .joins(:invoice)
                 .group('invoices.created_at')
                 .order('total DESC')
                 .first
                 .created_at
  end
end
