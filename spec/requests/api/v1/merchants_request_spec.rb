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

    get "/api/v1/merchants/find?name=#{merchant_2.name}"

    expect(response).to be_success

    merchant = JSON.parse(response.body)
    expect(merchant["id"]).to eq(merchant_2.id)
  end

  it 'finds one merchant by case insensitive name parameter' do
    merchant_1, merchant_2, merchant_3 = create_list(:merchant, 3)

    get "/api/v1/merchants/find?name=#{merchant_2.name.upcase}"

    expect(response).to be_success

    merchant = JSON.parse(response.body)
    expect(merchant["id"]).to eq(merchant_2.id)
  end

  it 'finds one merchant by created_at date' do
    created_at = "2017-03-12 14:53:59 UTC"
    merchant_1, merchant_2, merchant_3 = create_list(:merchant, 3, created_at: created_at)

    get "/api/v1/merchants/find?created_at=#{created_at}"

    expect(response).to be_success

    merchant = JSON.parse(response.body)
    expect(merchant["id"]).to eq(merchant_1.id)
  end

  it 'finds one merchant by updated_at date' do
    updated_at = "2017-03-12 14:53:59 UTC"
    merchant_1, merchant_2, merchant_3 = create_list(:merchant, 3, updated_at: updated_at)

    get "/api/v1/merchants/find?updated_at=#{updated_at}"

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

  it 'finds all merchants by name' do
    merchant_1 = create(:merchant, name: "Jane Doe")
    merchant_2 = create(:merchant, name: "John Doe")
    merchant_3 = create(:merchant, name: "Jane Doe")

    get "/api/v1/merchants/find_all?name=#{merchant_1.name}"

    expect(response).to be_success

    merchants = JSON.parse(response.body)
    expect(merchants.count).to eq(2)
    expect(merchants).to be_instance_of(Array)
  end

  it 'finds all merchants by created_at date' do
    created_at = "2017-03-12 14:53:59 UTC"
    merchant_1, merchant_2, merchant_3 = create_list(:merchant, 3, created_at: created_at)
    merchant_4 = create(:merchant, created_at: Date.yesterday)

    get "/api/v1/merchants/find_all?created_at=#{created_at}"

    expect(response).to be_success

    merchants = JSON.parse(response.body)
    expect(merchants.count).to eq(3)
  end

  it 'finds all merchants by updated_at date' do
    updated_at = "2017-03-12 14:53:59 UTC"
    merchant_1, merchant_2, merchant_3 = create_list(:merchant, 3, updated_at: updated_at)
    merchant_4 = create(:merchant, updated_at: Date.yesterday)

    get "/api/v1/merchants/find_all?updated_at=#{updated_at}"

    expect(response).to be_success

    merchants = JSON.parse(response.body)
    expect(merchants.count).to eq(3)
  end

  it 'returns 404 error if find params are invalid' do
    get "/api/v1/merchants/find?duck=goose"

    expect(response).to_not be_success
    expect(response.status).to eq(404)
  end

  it 'returns 404 error if find all params are invalid' do
    get "/api/v1/merchants/find_all?duck=goose"

    expect(response).to_not be_success
    expect(response.status).to eq(404)
  end

  it 'returns random merchant' do
    merchant_1, merchant_2, merchant_3 = create_list(:merchant, 3)

    get "/api/v1/merchants/random"

    expect(response).to be_success

    merchant = JSON.parse(response.body)
    expect(merchant[:id])
    expect(merchant[:name])
    expect(merchant[:created_at])
    expect(merchant[:updated_at])
  end
end
