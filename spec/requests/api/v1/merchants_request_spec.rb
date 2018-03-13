require 'rails_helper'

describe 'Merchants API' do
  it 'sends a list of merchants' do
    create_list(:merchant, 5)

    get "/api/v1/merchants.json"

    expect(response).to be_success

    merchants = JSON.parse(response.body)
    expect(merchants.count).to eq(5)
  end

  it 'sends one merchant by id' do
    create_list(:merchant, 5)
    id = create(:merchant).id

    get "/api/v1/merchants/#{id}.json"

    expect(response).to be_success

    merchant = JSON.parse(response.body)
    expect(merchant["id"]).to eq(id)
  end

  it 'finds one merchant by id parameter' do
    merchant_1, merchant_2, merchant_3 = create_list(:merchant, 3)

    get "/api/v1/merchants/find?id=#{merchant_2.id}"

    expect(response).to be_success

    merchant = JSON.parse(response.body)
    expect(merchant["id"]).to eq(merchant_2.id)
  end

  it 'finds one merchant by name parameter' do
    merchant_1, merchant_2, merchant_3 = create_list(:merchant, 3)

    get "/api/v1/merchants/find?name=#{merchant_2.name.gsub(" ", "_")}"

    expect(response).to be_success

    merchant = JSON.parse(response.body)
    expect(merchant["id"]).to eq(merchant_2.id)
  end

  it 'finds one merchant by case insensitive name parameter' do
    merchant_1, merchant_2, merchant_3 = create_list(:merchant, 3)

    get "/api/v1/merchants/find?name=#{merchant_2.name.gsub(" ", "_").upcase}"

    expect(response).to be_success

    merchant = JSON.parse(response.body)
    expect(merchant["id"]).to eq(merchant_2.id)
  end

  it 'finds one merchant by created_at date' do
    merchant_1, merchant_2, merchant_3 = create_list(:merchant, 3)

    get "/api/v1/merchants/find?created_at=#{merchant_1.created_at}"

    expect(response).to be_success

    merchant = JSON.parse(response.body)
    expect(merchant["id"]).to eq(merchant_1.id)
  end

  it 'finds one merchant by updated_at date' do
    merchant_1, merchant_2, merchant_3 = create_list(:merchant, 3)

    get "/api/v1/merchants/find?updated_at=#{merchant_1.updated_at}"

    expect(response).to be_success

    merchant = JSON.parse(response.body)
    expect(merchant["id"]).to eq(merchant_1.id)
  end

  it 'finds all merchants by id' do
    merchant_1 = create(:merchant, name: "Jane Doe")
    merchant_2 = create(:merchant, name: "John Doe")
    merchant_3 = create(:merchant, name: "Jane Doe")

    get "/api/v1/merchants/find_all?id=#{merchant_1.id}"

    expect(response).to be_success

    merchants = JSON.parse(response.body)
    expect(merchants).to be_instance_of(Array)
  end
end
