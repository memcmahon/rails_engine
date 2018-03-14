class Customer < ApplicationRecord
  validates_presence_of :first_name, :last_name
  has_many :invoices

  def self.random_record
    all.sample(1)[0]
  end

  def self.favorite_customer(merchant_id)
    select("customers.*, count(transactions.id) AS transactions_count")
    .joins(invoices: :transactions)
    .where("transactions.result = 'success'")
    .where("invoices.merchant_id = #{merchant_id}")
    .group(:id)
    .order("transactions_count desc")
    .first
  end
end
