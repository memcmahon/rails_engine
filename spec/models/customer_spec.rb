require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe "Validations" do
    it { should validate_presence_of :first_name }
    it { should validate_presence_of :last_name }
  end

  describe "Relationships" do
    it { should have_many :invoices }
  end

  it "returns a customer's favorite merchant" do
    customer = create(:customer)
    merchant_1, merchant_2 = create_list(:merchant, 2)
    invoice_1 = create(:invoice, customer: customer, merchant: merchant_1)
    invoice_2 = create(:invoice, customer: customer, merchant: merchant_1)
    invoice_3 = create(:invoice, customer: customer, merchant: merchant_2)
    invoice_4 = create(:invoice, customer: customer, merchant: merchant_2)
    invoice_5 = create(:invoice, customer: customer, merchant: merchant_1)
    transaction_1 = create(:transaction, invoice: invoice_1)
    transaction_2 = create(:transaction, invoice: invoice_2, result: 'failed')
    transaction_3 = create(:transaction, invoice: invoice_2)
    transaction_4 = create(:transaction, invoice: invoice_3, result: 'failed')
    transaction_6 = create(:transaction, invoice: invoice_4)
    transaction_7 = create(:transaction, invoice: invoice_5)

    expect(customer.favorite_merchant["id"]).to eq(merchant_1.id)
  end
end
