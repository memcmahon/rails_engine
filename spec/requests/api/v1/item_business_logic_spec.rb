require 'rails_helper'

describe 'Items Business Logic APIs' do
  it "should return the best day for an individual item" do
    item = create(:item)
    invoice_1 = create(:invoice, created_at: "2017-03-14 12:12:12 UTC")
    invoice_2 = create(:invoice, created_at: "2017-09-14 12:12:12 UTC")
    invoice_item_1 = create(:invoice_item, quantity: 3, invoice: invoice_2, item: item)
    invoice_item_2 = create(:invoice_item, quantity: 2, invoice: invoice_1, item: item)

    get "/api/v1/items/#{item.id}/best_day"

    expect(response).to be_success

    best_day = JSON.parse(response.body)["best_day"]
    expect(best_day.to_json).to eq(invoice_2.created_at.to_json)
  end

  it "sends top x items ranked by total revenue generated" do
    item_1 = create(:item, name: "Thing3", unit_price: 10000)
    item_2 = create(:item, name: "Thing1", unit_price: 20000)
    item_3 = create(:item, name: "Thing2", unit_price: 30000)
    invoice_1 = create(:invoice)
    invoice_2 = create(:invoice)
    invoice_3 = create(:invoice)
    invoice_item_1 = create(:invoice_item, item_id: item_1.id, invoice_id: invoice_1.id, quantity: 1, unit_price: 10000)
    invoice_item_2 = create(:invoice_item, item_id: item_2.id, invoice_id: invoice_1.id, quantity: 2, unit_price: 20000)
    invoice_item_3 = create(:invoice_item, item_id: item_3.id, invoice_id: invoice_2.id, quantity: 1, unit_price: 30000)
    invoice_item_4 = create(:invoice_item, item_id: item_3.id, invoice_id: invoice_3.id, quantity: 2, unit_price: 30000)
    transaction_1 = create(:transaction, invoice_id: invoice_1.id, result: 'success')
    transaction_2 = create(:transaction, invoice_id: invoice_2.id, result: 'failed')
    transaction_3 = create(:transaction, invoice_id: invoice_2.id, result: 'success')
    transaction_4 = create(:transaction, invoice_id: invoice_3.id, result: 'failed')

    get "/api/v1/items/most_revenue?quantity=2"

    items = JSON.parse(response.body)

    expect(response).to be_success
    expect(items.count).to eq(2)
    expect(items.first["name"]).to eq("Thing1")
    expect(items.last["name"]).to eq("Thing2")
  end

  it "sends top x items ranked by total items sold" do
    item_1, item_2 = create_list(:item, 2, name: "Thing")
    merchant = create(:merchant, name: "Jane Doe")
    invoice = create(:invoice, merchant: merchant)
    transaction = create(:transaction, invoice: invoice)
    invoice_item_1, invoice_item_2 = create_list(:invoice_item, 2, item: item_1, invoice: invoice)
    invoice_item_3 = create(:invoice_item, quantity: 12, item: item_2, invoice: invoice)

    get "/api/v1/items/most_items?quantity=2"

    expect(response).to be_success

    items = JSON.parse(response.body)

    expect(items.count).to eq(2)
    expect(items.first["id"]).to eq(item_2.id)
    expect(items.last["id"]).to eq(item_1.id)
  end
end
