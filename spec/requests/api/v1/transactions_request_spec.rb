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

  it 'finds one transaction by invoice_id parameter' do
    transaction_1, transaction_2, transaction_3 = create_list(:transaction, 3)

    get "/api/v1/transactions/find?invoice_id=#{transaction_2.invoice_id}"

    expect(response).to be_success

    transaction = JSON.parse(response.body)
    expect(transaction["id"]).to eq(transaction_2.id)
  end

  it 'finds one transaction by credit_card_number parameter' do
    transaction_1, transaction_2, transaction_3 = create_list(:transaction, 3)

    get "/api/v1/transactions/find?credit_card_number=#{transaction_2.credit_card_number}"

    expect(response).to be_success

    transaction = JSON.parse(response.body)
    expect(transaction["id"]).to eq(transaction_2.id)
  end

  it 'finds one transaction by result parameter' do
    transaction_1, transaction_2, transaction_3 = create_list(:transaction, 3, result: 'failed')
    transaction_4 = create(:transaction)

    get "/api/v1/transactions/find?result=#{transaction_4.result}"

    expect(response).to be_success

    transaction = JSON.parse(response.body)
    expect(transaction["id"]).to eq(transaction_4.id)
  end
  it 'finds one transaction by created_at parameter' do
    created_at = "2017-03-14 12:12:12 UTC"
    transaction_1, transaction_2, transaction_3 = create_list(:transaction, 3)
    transaction_4 = create(:transaction, created_at: created_at)

    get "/api/v1/transactions/find?created_at=#{created_at}"

    expect(response).to be_success

    transaction = JSON.parse(response.body)
    expect(transaction["id"]).to eq(transaction_4.id)
  end
  it 'finds one transaction by updated_at parameter' do
    updated_at = "2017-03-14 12:12:12 UTC"
    transaction_1, transaction_2, transaction_3 = create_list(:transaction, 3)
    transaction_4 = create(:transaction, updated_at: updated_at)

    get "/api/v1/transactions/find?updated_at=#{updated_at}"

    expect(response).to be_success

    transaction = JSON.parse(response.body)
    expect(transaction["id"]).to eq(transaction_4.id)
  end
end
