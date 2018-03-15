require 'rails_helper'

describe "Items API" do
  before :each do
    @invoice_item_1 = create(:invoice_item, unit_price: 1300)
    @invoice_item_2 = create(:invoice_item)
    @invoice_item_3 = create(:invoice_item)
  end

  it "send all invoice_items" do
    get "/api/v1/invoice_items.json"

    invoice_items = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoice_items.count).to eq(3)
  end

  it "sends all invoice_items" do
    get "/api/v1/invoice_items/#{@invoice_item_1.id}.json"

    invoice_item = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoice_item["id"]).to eq(@invoice_item_1.id)
  end

  it "sends one invoice_items with matching id" do
    get "/api/v1/invoice_items/find?id=#{@invoice_item_1.id}"

    invoice_item = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoice_item["id"]).to eq(@invoice_item_1.id)
  end

  it "sends one invoice_item with matching item_id" do
    get "/api/v1/invoice_items/find?item_id=#{@invoice_item_1.item_id}"

    invoice_item = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoice_item["item_id"]).to eq(@invoice_item_1.item_id)
  end

  it "sends one invoice_item with matching invoice_id" do
    get "/api/v1/invoice_items/find?invoice_id=#{@invoice_item_1.invoice_id}"

    invoice_item = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoice_item["invoice_id"]).to eq(@invoice_item_1.invoice_id)
  end

  it "sends one invoice_item with matching quantity" do
    get "/api/v1/invoice_items/find?quantity=#{@invoice_item_1.quantity}"

    invoice_item = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoice_item["quantity"]).to eq(@invoice_item_1.quantity)
  end

  it "sends one invoice_item with matching unit_price" do
    get "/api/v1/invoice_items/find?unit_price=13.00"

    invoice_item = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoice_item["unit_price"]).to eq("13.0")
  end

  it "sends one invoice_item with mathcing created_at" do
    date = "2017-03-12 14:53:59 UTC"
    invoice_item_4 = create(:invoice_item, created_at: date)
    get "/api/v1/invoice_items/find?created_at=#{date}"

    invoice_item = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoice_item["id"]).to eq(invoice_item_4.id)
  end

  it "sends one invoice_item with matching updated_at" do
    date = "2017-03-12 14:53:59 UTC"
    invoice_item_5 = create(:invoice_item, updated_at: date)
    get "/api/v1/invoice_items/find?updated_at=#{date}"

    invoice_item = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoice_item["id"]).to eq(invoice_item_5.id)
  end

  it "responds with 404 if key does not exist" do
    get "/api/v1/invoice_items/find?banana=pie"

    expect(response).to_not be_success
  end

  it "sends all invoice_items with matching id" do
    get "/api/v1/invoice_items/find_all?id=#{@invoice_item_1.id}"

    invoice_items = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoice_items.first["id"]).to eq(@invoice_item_1.id)
  end

  it "sends all invoice_items with matching item_id" do
    get "/api/v1/invoice_items/find_all?item_id=#{@invoice_item_1.item_id}"

    invoice_items = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoice_items.first["item_id"]).to eq(@invoice_item_1.item_id)
  end

  it "sends all invoice_items with matching invoice_id" do
    get "/api/v1/invoice_items/find_all?invoice_id=#{@invoice_item_1.invoice_id}"

    invoice_items = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoice_items.first["invoice_id"]).to eq(@invoice_item_1.invoice_id)
  end

  it "sends all invoice_items with matching quantity" do
    get "/api/v1/invoice_items/find_all?quantity=#{@invoice_item_1.quantity}"

    invoice_items = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoice_items.first["quantity"]).to eq(@invoice_item_1.quantity)
  end

  it "sends all invoice_items with matching unit_price" do
    get "/api/v1/invoice_items/find_all?unit_price=13.00"

    invoice_items = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoice_items.first["unit_price"]).to eq("13.0")
  end

  it "sends all invoice_items with matching created_at" do
    date = "2017-03-12 14:53:59 UTC"
    invoice_item_4 = create(:invoice_item, created_at: date)
    invoice_item_5 = create(:invoice_item, created_at: date)
    get "/api/v1/invoice_items/find_all?created_at=#{date}"

    invoice_items = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoice_items.count).to eq(2)
  end

  it "sends all invoice_items with matching updated_at" do
    date = "2017-03-12 14:53:59 UTC"
    invoice_item_6 = create(:invoice_item, updated_at: date)
    invoice_item_7 = create(:invoice_item, updated_at: date)
    get "/api/v1/invoice_items/find_all?updated_at=#{date}"

    invoice_items = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoice_items.count).to eq(2)
  end

  it "sends random invoice_item" do
    get "/api/v1/invoice_items/random.json"

    expect(response).to be_success
  end
end
