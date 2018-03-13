class Merchant < ApplicationRecord
  validates_presence_of :name

  has_many :invoices
  has_many :items

  scope :find_all_by_attribute, ->(attribute) { where(attribute) }
  scope :find_by_attribute, ->(attribute) { find_by(attribute) }

  def self.random_record
    all.sample(1)[0]
  end
end
