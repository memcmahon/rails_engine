require 'rails_helper'

describe "Transactions Relationships API" do
  before :each do
    @invoice = create(:invoice)
    @transaction_1 = create(:transaction, invoice_id: @invoice.id)
  end
 it "sends the associated invoice" do
   get "/api/v1/transactions/#{@transaction_1.id}/invoice"

   invoice = JSON.parse(response.body)

   expect(response).to be_success
   expect(invoice["id"]).to eq(@invoice.id)
 end
end
