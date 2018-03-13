class Transaction < ApplicationRecord
  validates_presence_of :invoice_id, :credit_card_number, :result

  belongs_to :invoice

  def self.random_record
    all.sample(1)[0]
  end
end
