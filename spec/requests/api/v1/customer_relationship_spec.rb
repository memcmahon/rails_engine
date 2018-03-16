require 'rails_helper'

describe "Customers Relationships API" do
  before :each do
    @customer_1 = create(:customer)
    @customer_2 = create(:customer)
    @invoice_1 = create(:invoice, customer_id: @customer_1.id)
    @invoice_2 = create(:invoice, customer_id: @customer_1.id)
    @invoice_3 = create(:invoice, customer_id: @customer_2.id)
    @transaction_1 = create(:transaction, invoice_id: @invoice_1.id)
    @transaction_2 = create(:transaction, invoice_id: @invoice_2.id)
    @transaction_3 = create(:transaction, invoice_id: @invoice_2.id)
    @transaction_4 = create(:transaction, invoice_id: @invoice_3.id)
  end

 it "sends the associated invoices" do
   get "/api/v1/customers/#{@customer_1.id}/invoices"

   invoices = JSON.parse(response.body)

   expect(response).to be_success
   expect(invoices.count).to eq(2)
 end

 it "sends the associated transactions" do
   get "/api/v1/customers/#{@customer_1.id}/transactions"

   transactions = JSON.parse(response.body)

   expect(response).to be_success
   expect(transactions.count).to eq(3)
 end
end
