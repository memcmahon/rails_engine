require 'rails_helper'

describe "Customer Business Intel API" do
  it "sends back a single customer's favorite merchant" do
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

    get "/api/v1/customers/#{customer.id}/favorite_merchant"

    expect(response).to be_success

    merchant = JSON.parse(response.body)

    expect(merchant["id"]).to eq(merchant_1.id)
  end
end
