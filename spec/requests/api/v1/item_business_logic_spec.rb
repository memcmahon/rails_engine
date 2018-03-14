require 'rails_helper'

describe 'Items Business Logic APIs' do
  it "should return the best day for an individual item" do
    item = create(:item)
    invoice_1 = create(:invoice, created_at: "2017-03-14 12:12:12 UTC")
    invoice_2 = create(:invoice, created_at: "2017-09-14 12:12:12 UTC")
    invoice_item_1 = create(:invoice_item, quantity: 3, invoice: invoice_2, item: item)
    invoice_item_2 = create(:invoice_item, quantity: 2, invoice: invoice_1, item: item)

    visit "/api/v1/items/#{item.id}/best_day"

    expect(response).to be_success

    best_day = JSON.parse(response.body)
    expect(best_day).to eq(invoice_2.created_at)
  end
end
