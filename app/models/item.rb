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

  def best_invoice_id
    invoice_items.select('invoice_id, SUM(quantity) AS total')
                 .group('invoice_id')
                 .order('total DESC')
                 .first
                 .invoice_id
  end

  def best_day
    invoices.find(best_invoice_id).created_at
  end
end
