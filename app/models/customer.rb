class Customer < ApplicationRecord
  validates_presence_of :first_name, :last_name
  has_many :invoices

  def self.random_record
    all.sample(1)[0]
  end
end
