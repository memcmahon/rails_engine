require 'rails_helper'

describe "Customer Business Intel API" do
  it "sends back a single customer's favorite merchant" do
    customer = create(:customer)
    merchant_1, merchant_2 = create_list(:merchant, 2)
    invoice_1 = create(:invoice, customer: customer, merchant: merchant_1)
  end
end
