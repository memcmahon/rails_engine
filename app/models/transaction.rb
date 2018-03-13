class Transaction < ApplicationRecord
  validates_presence_of :invoice_id, :credit_card_number, :result
end
