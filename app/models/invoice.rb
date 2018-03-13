class Invoice < ApplicationRecord
  validates_presence_of :customer_id, :merchant_id, :status
  belongs_to :customer
  belongs_to :merchant

  scope :find_by_attribute, ->(attribute) { find_by(attribute) }
  scope :find_all_by_attribute, ->(attribute) { where(attribute) }

  def self.random
    order("RANDOM()").first
  end
end
