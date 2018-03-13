require 'rails_helper'

describe "Invoices API" do
  before :each do
    @invoice_1 = create(:invoice)
    @invoice_2 = create(:invoice, status: "pending")
    @invoice_3 = create(:invoice)
  end

  it "sends a list of all invoices" do
    get "/api/v1/invoices.json"

    invoices = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoices.count).to eq(3)
  end

  it "sends one invoice" do
    get "/api/v1/invoices/#{@invoice_1.id}.json"

    invoice = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoice["id"]).to eq(@invoice_1.id)
  end

  it "sends one invoice based on id" do
    get "/api/v1/invoices/find?id=#{@invoice_1.id}"

    invoice = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoice["id"]).to eq(@invoice_1.id)
  end

  it "sends one invoice based on customer id" do
    get "/api/v1/invoices/find?customer_id=#{@invoice_1.customer_id}"

    invoice = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoice["customer_id"]).to eq(@invoice_1.customer_id)
  end

  it "sends one invoice based on merchant id" do
    get "/api/v1/invoices/find?merchant_id=#{@invoice_1.merchant_id}"

    invoice = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoice["merchant_id"]).to eq(@invoice_1.merchant_id)
  end

  it "sends one invoice based on status" do
    get "/api/v1/invoices/find?status=#{@invoice_2.status}"

    invoice = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoice["status"]).to eq("pending")
  end

  it "sends one invoice based on created_at" do
    date = "2017-03-12 14:53:59 UTC"
    invoice_1 = create(:invoice, created_at: date)
    get "/api/v1/invoices/find?created_at=#{date}"

    invoice = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoice["id"]).to eq(invoice_1.id)
  end

  it "sends one invoice based on updated_at" do
    date = "2017-03-12 14:53:59 UTC"
    invoice_1 = create(:invoice, updated_at: date)
    get "/api/v1/invoices/find?updated_at=#{date}"

    invoice = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoice["id"]).to eq(invoice_1.id)
  end

  it "renders 404 if key does not exist" do
    get "/api/v1/invoices/find?movie=loveactually"

    expect(response).to_not be_success
  end

  it "sends all invoices based on id" do
    get "/api/v1/invoices/find_all?id=#{@invoice_1.id}"

    invoices = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoices[0]["id"]).to eq(@invoice_1.id)
  end

  it "sends all invoices based on customer id" do
    customer = create(:customer)
    invoice_4 = create(:invoice, customer_id: customer.id)
    invoice_5 = create(:invoice, customer_id: customer.id)
    invoice_6 = create(:invoice, customer_id: customer.id)
    get "/api/v1/invoices/find_all?customer_id=#{invoice_4.customer_id}"

    invoices = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoices.count).to eq(3)
  end

  it "sends all invoices based on merchant id" do
    merchant = create(:merchant)
    invoice_4 = create(:invoice, merchant_id: merchant.id)
    invoice_5 = create(:invoice, merchant_id: merchant.id)
    invoice_6 = create(:invoice, merchant_id: merchant.id)
    get "/api/v1/invoices/find_all?merchant_id=#{invoice_4.merchant_id}"

    invoices = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoices.count).to eq(3)
  end

  it "sends all invoices based on status" do
    get "/api/v1/invoices/find_all?status=shipped"

    invoices = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoices.count).to eq(2)
  end

  it "sends all invoices based on created_at" do
    date = "2018-03-12 14:53:59 UTC"
    invoice_1 = create(:invoice, created_at: date)
    invoice_2 = create(:invoice, created_at: date)
    get "/api/v1/invoices/find_all?created_at=#{date}"

    invoices = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoices.count).to eq(2)
  end

  it "sends all invoices based on updated_at" do
    date = "2018-03-12 14:53:59 UTC"
    invoice_1 = create(:invoice, updated_at: date)
    invoice_2 = create(:invoice, updated_at: date)
    get "/api/v1/invoices/find_all?updated_at=#{date}"

    invoices = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoices.count).to eq(2)
  end

  it "renders 404 if key does not exist" do
    get "/api/v1/invoices/find_all?movie=loveactually"

    expect(response).to_not be_success
  end

  it "sends random merchant" do
    get "/api/v1/invoices/random.json"

    expect(response).to be_success
  end
end
