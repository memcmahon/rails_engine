require 'rails_helper'

describe "Merchants Relationships API" do
  before :each do
    @merchant_1 = create(:merchant)
    @merchant_2 = create(:merchant)
    @item_1 = create(:item, merchant_id: @merchant_1.id)
    @item_2 = create(:item, merchant_id: @merchant_1.id)
    @item_3 = create(:item, merchant_id: @merchant_1.id)
    @item_4 = create(:item, merchant_id: @merchant_2.id)
  end

  it "sends a list of all items associated with a merchant" do
    get "/api/v1/merchants/#{@merchant_1.id}/items"

    items = JSON.parse(response.body)
binding.pry
    expect(response).to be_success
    expect(items["items"].count).to eq(3)
    expect(items["items"].first["merchant_id"]).to eq(@merchant_1.id)
  end
end
