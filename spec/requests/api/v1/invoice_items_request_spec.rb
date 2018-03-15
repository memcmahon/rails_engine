require 'rails_helper'

describe "Items API" do
  before :each do
    @invoice_item_1 = create(:invoice_item)
    @invoice_item_2 = create(:invoice_item)
    @invoice_item_3 = create(:invoice_item)
  end

  it "send all invoice_items" do
    get "/api/v1/invoice_items.json"

    invoice_items = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoice_items.count).to eq(3)
  end
end
