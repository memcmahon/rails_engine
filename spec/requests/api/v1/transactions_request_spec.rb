require 'rails_helper'

describe 'Transactions API' do
  it 'sends a list of transactions' do
    create_list(:transaction, 5)

    get "/api/v1/transactions.json"

    expect(response).to be_success

    merchants = JSON.parse(response.body)
    expect(merchants.count).to eq(5)
  end

  it 'sends one transaction by id' do
    create_list(:transaction, 5)
    id = create(:transaction).id

    get "/api/v1/transactions/#{id}.json"

    expect(response).to be_success

    transaction = JSON.parse(response.body)
    expect(transaction["id"]).to eq(id)
  end

  it 'finds one transaction by id parameter' do
    transaction_1, transaction_2, transaction_3 = create_list(:transaction, 3)

    get "/api/v1/transactions/find?id=#{transaction_2.id}"

    expect(response).to be_success

    transaction = JSON.parse(response.body)
    expect(transaction["id"]).to eq(transaction_2.id)
  end
end
