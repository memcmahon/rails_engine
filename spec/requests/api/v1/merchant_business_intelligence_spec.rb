require 'rails_helper'

describe "Merchant Business Intelligence API" do
  before :each do
    @merchant_1 = create(:merchant)
    @merchant_2 = create(:merchant)
    @merchant_3 = create(:merchant)
    @item_1 = create(:item, unit_price: 10000, merchant_id: @merchant_1.id)
    @item_2 = create(:item, unit_price: 20000, merchant_id: @merchant_1.id)
    @item_3 = create(:item, unit_price: 40000, merchant_id: @merchant_1.id)
    @item_4 = create(:item, unit_price: 10000, merchant_id: @merchant_2.id)
    @item_5 = create(:item, unit_price: 20000, merchant_id: @merchant_2.id)
    @item_6 = create(:item, unit_price: 50000, merchant_id: @merchant_3.id)
    @invoice_1 = create(:invoice, merchant_id: @merchant_1.id)
    @invoice_2 = create(:invoice, merchant_id: @merchant_1.id)
    @invoice_3 = create(:invoice, merchant_id: @merchant_2.id)
    @invoice_4 = create(:invoice, merchant_id: @merchant_3.id)
    @invoice_5 = create(:invoice, merchant_id: @merchant_3.id)
    @invoice_item_1a = create(:invoice_item, invoice_id: @invoice_1.id, item_id: @item_1.id, unit_price: 10000, quantity: 1)
    @invoice_item_1b = create(:invoice_item, invoice_id: @invoice_1.id, item_id: @item_2.id, unit_price: 20000, quantity: 1)
    @invoice_item_2a = create(:invoice_item, invoice_id: @invoice_2.id, item_id: @item_1.id, unit_price: 10000, quantity: 2)
    @invoice_item_2b = create(:invoice_item, invoice_id: @invoice_2.id, item_id: @item_2.id, unit_price: 20000, quantity: 1)
    @invoice_item_3a = create(:invoice_item, invoice_id: @invoice_3.id, item_id: @item_4.id, unit_price: 13000, quantity: 2)
    @invoice_item_3b = create(:invoice_item, invoice_id: @invoice_3.id, item_id: @item_5.id, unit_price: 20000, quantity: 1)
    @invoice_item_4 = create(:invoice_item, invoice_id: @invoice_4.id, item_id: @item_6.id, unit_price: 50000, quantity: 1)
    @invoice_item_5 = create(:invoice_item, invoice_id: @invoice_5.id, item_id: @item_6.id, unit_price: 50000, quantity: 1)
    @transaction_1 = create(:transaction, invoice_id: @invoice_1.id, result: "success")
    @transaction_2 = create(:transaction, invoice_id: @invoice_2.id, result: "success")
    @transaction_3 = create(:transaction, invoice_id: @invoice_3.id, result: "success")
    @transaction_4 = create(:transaction, invoice_id: @invoice_4.id, result: "success")
    @transaction_5 = create(:transaction, invoice_id: @invoice_5.id, result: "failed")
  end

  it "sends top x merchants ranked by total revenue" do
    get '/api/v1/merchants/most_revenue?quantity=2'

    merchants = JSON.parse(response.body)

    expect(merchants.count).to eq(2)
    expect(merchants.first["id"]).to eq(@merchant_1.id)
    expect(merchants.first["merchant_revenue"]).to eq(70000)
  end

  it "sends customer who has conducted the most total number of successful transactions" do
    merchant = create(:merchant)
    customer_1 = create(:customer)
    customer_2 = create(:customer)
    invoice_6 = create(:invoice, merchant_id: merchant.id, customer_id: customer_1.id)
    invoice_7 = create(:invoice, merchant_id: merchant.id, customer_id: customer_1.id)
    invoice_8 = create(:invoice, merchant_id: merchant.id, customer_id: customer_2.id)
    transaction_6 = create(:transaction, invoice_id: invoice_6.id, result: "success")
    transaction_7 = create(:transaction, invoice_id: invoice_7.id, result: "success")
    transaction_8 = create(:transaction, invoice_id: invoice_8.id, result: "success")
    transaction_9 = create(:transaction, invoice_id: invoice_6.id, result: "failed")

    get "/api/v1/merchants/#{merchant.id}/favorite_customer"

    customer = JSON.parse(response.body)

    expect(customer["id"]).to eq(customer_1.id)
    expect(customer["transactions_count"]).to eq(2)
  end

  it "sends revenue for a single merchant" do
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

    get "/api/v1/merchants/#{merchant.id}/revenue"

    expect(response).to be_success

    revenue = JSON.parse(response.body)["revenue"]

    expect(revenue).to eq("12.0")
  end

  it "sends revenue for a single merchant by date" do
    created_date = "2012-03-16 12:24:23"
    merchant = create(:merchant)
    invoice_1, invoice_2 = create_list(:invoice, 2, merchant: merchant, created_at: created_date)
    invoice_3 = create(:invoice, merchant: merchant)
    invoice_4 = create(:invoice)
    transaction_1 = create(:transaction, invoice: invoice_1)
    transaction_2 = create(:transaction, invoice: invoice_2, result: "failed")
    transaction_3 = create(:transaction, invoice: invoice_3)
    transaction_4 = create(:transaction, invoice: invoice_4)
    invoice_item_1 = create(:invoice_item, invoice: invoice_1, unit_price: 300, quantity: 1)
    invoice_item_2 = create(:invoice_item, invoice: invoice_2, unit_price: 300, quantity: 2)
    invoice_item_3 = create(:invoice_item, invoice: invoice_3, unit_price: 300, quantity: 3)
    invoice_item_4 = create(:invoice_item, invoice: invoice_4)

    get "/api/v1/merchants/#{merchant.id}/revenue?date=2012-03-16"

    expect(response).to be_success

    revenue = JSON.parse(response.body)["revenue"]
    expect(revenue).to eq("9.0")
  end
end
