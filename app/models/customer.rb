class Customer < ApplicationRecord
  default_scope {order(:id)}
  validates_presence_of :first_name, :last_name
  has_many :invoices

  def self.random_record
    all.sample(1)[0]
  end

  def self.favorite_customer(merchant_id)
    select("customers.*, count(transactions.id) AS transactions_count")
    .joins(invoices: :transactions)
    .merge(Transaction.successful)
    .where("invoices.merchant_id = #{merchant_id}")
    .group(:id)
    .order("transactions_count desc")
    .first
  end

  def self.pending_invoices(merchant_id)
    find_by_sql(
      "SELECT customers.* FROM customers
        JOIN invoices ON invoices.customer_id = customers.id
        JOIN transactions ON transactions.invoice_id = invoices.id
        WHERE transactions.result = 'failed'
        AND invoices.merchant_id = #{merchant_id.to_i}
        EXCEPT
        SELECT customers.* FROM customers
        JOIN invoices ON invoices.customer_id = customers.id
        JOIN transactions ON transactions.invoice_id = invoices.id
        WHERE transactions.result = 'success'
        AND invoices.merchant_id = #{merchant_id.to_i}"
    )
  end

  def favorite_merchant
    invoices.includes(:merchant)
    .select("invoices.merchant_id, COUNT(invoices.id) AS total")
    .joins(:transactions)
    .where(transactions: {result: "success"})
    .group(:merchant_id).order("total DESC")
    .first
    .merchant
  end
end
