require 'rails_helper'

describe 'Invoice Relationship APIs' do
  before(:each) do
    @merchant = create(:merchant)
    @customer = create(:customer)
    @invoice = create(:invoice, customer: @customer, merchant: @merchant)
    @item = create(:item)
    @transaction_1, @transaction_2, @transaction_3 = create_list(:transaction, 3, invoice: @invoice)
    @transaction_4 = create(:transaction)
    @invoice_item_1, @invoice_item_2, @invoice_item_3 = create_list(:invoice_item, 3, invoice: @invoice, item: @item)
    @invoice_item_4 = create(:invoice_item)
  end

  it "sends the transactions for an invoice" do
    get "/api/v1/invoices/#{@invoice.id}/transactions"

    expect(response).to be_success

    transactions = JSON.parse(response.body)

    expect(transactions.count).to eq(3)
    expect(transactions.first["id"]).to eq(@transaction_1.id)
  end

  it "sends the invoice_items for an invoice" do
    get "/api/v1/invoices/#{@invoice.id}/invoice_items"

    expect(response).to be_success

    invoice_items = JSON.parse(response.body)

    expect(invoice_items.count).to eq(3)
    expect(invoice_items.first["id"]).to eq(@invoice_item_1.id)
  end

  it "sends the items for an invoice" do
    get "/api/v1/invoices/#{@invoice.id}/items"

    expect(response).to be_success

    items = JSON.parse(response.body)

    expect(items.count).to eq(1)
    expect(items.first["id"]).to eq(@item.id)
  end

  it "sends the customer for an invoice" do
    get "/api/v1/invoices/#{@invoice.id}/customer"

    expect(response).to be_success

    customer = JSON.parse(response.body)

    expect(customer["id"]).to eq(@customer.id)
  end

  it "sends the merchant for an invoice" do
    get "/api/v1/invoices/#{@invoice.id}/merchant"

    expect(response).to be_success

    merchant = JSON.parse(response.body)

    expect(merchant["id"]).to eq(@merchant.id)
  end
end
