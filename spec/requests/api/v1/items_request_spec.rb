require 'rails_helper'

describe "Items API" do
  before :each do
    @item_1 = create(:item)
    @item_2 = create(:item)
    @item_3 = create(:item)
  end

  it "sends a list of all items" do
    get "/api/v1/items.json"

    items = JSON.parse(response.body)

    expect(response).to be_success
    expect(items.count).to eq(3)
  end

  it "sends one item" do
    get "/api/v1/items/#{@item_1.id}.json"

    item = JSON.parse(response.body)

    expect(response).to be_success
    expect(item["id"]).to eq(@item_1.id)
  end

  it "sends one item based on id" do
    get "/api/v1/items/find?id=#{@item_1.id}"

    item = JSON.parse(response.body)

    expect(response).to be_success
    expect(item["id"]).to eq(@item_1.id)
  end

  it "sends one item based on name" do
    item_4 = create(:item, name: "Bananagrams")
    get "/api/v1/items/find?name=#{item_4.name}"

    item = JSON.parse(response.body)

    expect(response).to be_success
    expect(item["name"]).to eq(item_4.name)
  end

  it "sends one item based on description" do
    item_4 = create(:item, description: "Simply the best")
    get "/api/v1/items/find?description=#{item_4.description}"

    item = JSON.parse(response.body)

    expect(response).to be_success
    expect(item["description"]).to eq(item_4.description)
  end

  it "sends one item based on unit price" do
    item_4 = create(:item, unit_price: 1000)
    get "/api/v1/items/find?unit_price=#{item_4.unit_price}"

    item = JSON.parse(response.body)

    expect(response).to be_success
    expect(item["unit_price"]).to eq(1000)
  end

  it "sends one item based on created_at" do
    date = "2017-03-12 14:53:59 UTC"
    item_1 = create(:item, created_at: date)
    get "/api/v1/items/find?created_at=#{date}"

    item = JSON.parse(response.body)

    expect(response).to be_success
    expect(item["id"]).to eq(item_1.id)
  end

  it "sends one item based on updated_at" do
    date = "2017-03-12 14:53:59 UTC"
    item_1 = create(:item, updated_at: date)
    get "/api/v1/items/find?updated_at=#{date}"

    item = JSON.parse(response.body)

    expect(response).to be_success
    expect(item["id"]).to eq(item_1.id)
  end

  it "renders 404 if key does not exist" do
    get "/api/v1/items/find?boardgame=monopoly"

    expect(response).to_not be_success
  end

  it "sends all items based on id" do
    get "/api/v1/items/find_all?id=#{@item_1.id}"

    items = JSON.parse(response.body)

    expect(response).to be_success
    expect(items[0]["id"]).to eq(@item_1.id)
  end

  it "sends all items based on name" do
    get "/api/v1/items/find_all?name=Lego"

    items = JSON.parse(response.body)

    expect(response).to be_success
    expect(items.count).to eq(3)
  end

  it "sends all items based on description" do
    get "/api/v1/items/find_all?description=#{@item_1.description}"

    items = JSON.parse(response.body)

    expect(response).to be_success
    expect(items.count).to eq(3)
  end

  it "sends all items based on unit price" do
    get "/api/v1/items/find_all?unit_price=10000"

    items = JSON.parse(response.body)

    expect(response).to be_success
    expect(items.count).to eq(3)
  end

  it "sends all items based on merchant id" do
    get "/api/v1/items/find_all?merchant_id=#{@item_1.merchant_id}"

    items = JSON.parse(response.body)

    expect(response).to be_success
    expect(items.count).to eq(1)
  end

  it "sends all items based on created_at" do
    date = "2018-03-12 14:53:59 UTC"
    item_1 = create(:item, created_at: date)
    item_2 = create(:item, created_at: date)
    get "/api/v1/items/find_all?created_at=#{date}"

    items = JSON.parse(response.body)

    expect(response).to be_success
    expect(items.count).to eq(2)
  end

  it "sends all items based on updated_at" do
    date = "2018-03-12 14:53:59 UTC"
    item_1 = create(:item, updated_at: date)
    item_2 = create(:item, updated_at: date)
    get "/api/v1/items/find_all?updated_at=#{date}"

    items = JSON.parse(response.body)

    expect(response).to be_success
    expect(items.count).to eq(2)
  end

  it "renders 404 if key does not exist" do
    get "/api/v1/items/find_all?boardgame=monopoly"

    expect(response).to_not be_success
  end

  it "sends random item" do
    get "/api/v1/items/random.json"

    expect(response).to be_success
  end
end
