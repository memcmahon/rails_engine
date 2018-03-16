class InvoiceItem < ApplicationRecord
  default_scope {order(:id)}
  validates_presence_of :item_id, :invoice_id, :quantity, :unit_price
  belongs_to :item
  belongs_to :invoice

  def self.random
    order("RANDOM()").first
  end
end
