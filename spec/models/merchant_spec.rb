require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe "Validations" do
    it { should validate_presence_of :name }
  end

  describe "Relationships" do
    it { should have_many :invoices }
    it { should have_many :items }
  end

  describe "Analytics" do
    it "Should return revenue by merchant" do
      merchant = create(:merchant)
      invoice_1, invoice_2, invoice_3 = create_list(:invoice, 3, merchant: merchant)
      invoice_4 = create(:invoice)
      transaction_1 = create(:transaction, invoice: invoice_1)
      transaction_2 = create(:transaction, invoice: invoice_2, result: "failed")
      transaction_3 = create(:transaction, invoice: invoice_3)
      transaction_4 = create(:transaction, invoice: invoice_4)
      invoice_item_1 = create(:invoice_item, invoice: invoice_1, unit_price: 300, quantity: 1)
      invoice_item_2 = create(:invoice_item, invoice: invoice_2, unit_price: 300, quantity: 2)
      invoice_item_3 = create(:invoice_item, invoice: invoice_3, unit_price: 300, quantity: 3)
      invoice_item_4 = create(:invoice_item, invoice: invoice_4)

      expect(merchant.revenue).to eq("12.0")
    end
  end
end
