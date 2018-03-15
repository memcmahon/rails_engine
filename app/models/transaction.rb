class Transaction < ApplicationRecord
  default_scope {order(:id)}
  validates_presence_of :invoice_id, :credit_card_number, :result
  belongs_to :invoice

  scope :successful, -> { where(result: 'success') }

  def self.random_record
    all.sample(1)[0]
  end
end
