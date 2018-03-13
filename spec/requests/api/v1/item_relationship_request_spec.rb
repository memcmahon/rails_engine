require 'rails_helper'

describe 'Items Relationship API' do
  it 'sends a list of invoice items' do
    item = create(:item)
    invoice_item_1, invoice_item_2, invoice_item_3 = create_list(:invoice_item, 3, item: item)
    invoice_item_4 = create(:invoice_item)

    get "/api/v1/items/#{item.id}/invoice_items"

    expect(response).to be_success

    invoice_items = JSON.parse(response.body)["invoice_items"]
    expect(invoice_items).to be_instance_of(Array)
    expect(invoice_items.count).to eq(3)
  end

  it 'sends the item merchant' do
    item = create(:item)

    get "/api/v1/items/#{item.id}/merchant"

    expect(response).to be_success

    merchant = JSON.parse(response.body)["merchant"]
    expect(merchant["id"]).to eq(item.merchant.id)
  end
end
