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
end
