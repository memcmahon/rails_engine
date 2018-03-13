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
end
