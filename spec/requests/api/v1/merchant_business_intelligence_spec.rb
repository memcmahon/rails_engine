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
    @invoice_item_1a = create(:invoice_item, invoice_id: @invoice_1.id, item_id: @item_1.id)
    @invoice_item_1b = create(:invoice_item, invoice_id: @invoice_1.id, item_id: @item_2.id)
    @invoice_item_2a = create(:invoice_item, invoice_id: @invoice_2.id, item_id: @item_1.id)
    @invoice_item_2b = create(:invoice_item, invoice_id: @invoice_2.id, item_id: @item_2.id)
    @invoice_item_3a = create(:invoice_item, invoice_id: @invoice_3.id, item_id: @item_4.id)
    @invoice_item_3b = create(:invoice_item, invoice_id: @invoice_3.id, item_id: @item_5.id)
    @invoice_item_4 = create(:invoice_item, invoice_id: @invoice_4.id, item_id: @item_6.id)
  end

  it "sends top x merchants ranked by total revenue" do
    get '/api/v1/merchants/most_revenue?quantity=2'

    merchants = JSON.parse(response.body)

    expect(merchants.count).to eq(2)
    expect(merchants.first["id"]).to eq(@merchant_1.id)
  end
end
