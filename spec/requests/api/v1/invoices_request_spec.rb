require 'rails_helper'

describe "Invoices API" do
  before :each do
    @invoice_1 = create(:invoice)
    @invoice_2 = create(:invoice, status: "pending")
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

  it "sends one invoice based on id" do
    get "/api/v1/invoices/find?id=#{@invoice_1.id}"

    item = JSON.parse(response.body)

    expect(response).to be_success
    expect(item["id"]).to eq(@invoice_1.id)
  end

  it "sends one invoice based on customer id" do
    get "/api/v1/invoices/find?customer_id=#{@invoice_1.customer_id}"

    item = JSON.parse(response.body)

    expect(response).to be_success
    expect(item["customer_id"]).to eq(@invoice_1.customer_id)
  end

  it "sends one invoice based on merchant id" do
    get "/api/v1/invoices/find?merchant_id=#{@invoice_1.merchant_id}"

    item = JSON.parse(response.body)

    expect(response).to be_success
    expect(item["merchant_id"]).to eq(@invoice_1.merchant_id)
  end

  it "sends one invoice based on status" do
    get "/api/v1/invoices/find?status=#{@invoice_2.status}"

    item = JSON.parse(response.body)

    expect(response).to be_success
    expect(item["status"]).to eq("pending")
  end

  xit "sends one invoice based on created_at" do
    get "/api/v1/invoices/find?created_at=#{@invoice_1.created_at}"

    item = JSON.parse(response.body)

    expect(response).to be_success
    expect(item["created_at"]).to eq(@invoice_1.created_at)
  end

  it "renders 404 if key does not exist", :type => :feature do
    visit "/api/v1/invoices/find?movie=loveactually"

    expect(page).to have_content("The page you were looking for doesn't exist")
  end

  it "sends all invoices based on id" do
    get "/api/v1/invoices/find_all?id=#{@invoice_1.id}"

    items = JSON.parse(response.body)

    expect(response).to be_success
    expect(items[0]["id"]).to eq(@invoice_1.id)
  end

  it "sends all invoices based on customer id" do
    customer = create(:customer)
    @invoice_4 = create(:invoice, customer_id: customer.id)
    @invoice_5 = create(:invoice, customer_id: customer.id)
    @invoice_6 = create(:invoice, customer_id: customer.id)
    get "/api/v1/invoices/find_all?customer_id=#{@invoice_4.customer_id}"

    items = JSON.parse(response.body)

    expect(response).to be_success
    expect(items.count).to eq(3)
  end

  it "sends all invoices based on merchant id" do
    merchant = create(:merchant)
    @invoice_4 = create(:invoice, merchant_id: merchant.id)
    @invoice_5 = create(:invoice, merchant_id: merchant.id)
    @invoice_6 = create(:invoice, merchant_id: merchant.id)
    get "/api/v1/invoices/find_all?merchant_id=#{@invoice_4.merchant_id}"

    items = JSON.parse(response.body)

    expect(response).to be_success
    expect(items.count).to eq(3)
  end

  it "sends all invoices based on status" do
    get "/api/v1/invoices/find_all?status=shipped"

    items = JSON.parse(response.body)

    expect(response).to be_success
    expect(items.count).to eq(2)
  end
end
