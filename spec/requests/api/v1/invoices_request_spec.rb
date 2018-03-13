require 'rails_helper'

describe "Invoices API" do
  before :each do
    @invoice_1 = create(:invoice)
    @invoice_2 = create(:invoice)
    @invoice_3 = create(:invoice)
  end

  it "sends a list of all invoices" do
    get "/api/v1/invoices.json"

    items = JSON.parse(response.body)

    expect(response).to be_success
    expect(items.count).to eq(3)
  end

  it "sends one invoice" do
    get "/api/v1/invoices/#{@invoice_1.id}.json"

    item = JSON.parse(response.body)

    expect(response).to be_success
    expect(item["id"]).to eq(@invoice_1.id)
  end
end
