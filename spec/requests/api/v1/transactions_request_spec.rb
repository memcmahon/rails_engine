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

  it 'finds one transaction by case insensitive result parameter' do
    transaction_1, transaction_2, transaction_3 = create_list(:transaction, 3, result: 'failed')
    transaction_4 = create(:transaction)

    get "/api/v1/transactions/find?result=SUCcESs"

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

  it 'finds all transactions by id parameter' do
    transaction_1, transaction_2, transaction_3 = create_list(:transaction, 3)

    get "/api/v1/transactions/find_all?id=#{transaction_2.id}"

    expect(response).to be_success

    transactions = JSON.parse(response.body)
    expect(transactions).to be_instance_of(Array)
    expect(transactions[0]["id"]).to eq(transaction_2.id)
  end

  it 'finds all transactions by invoice_id parameter' do
    invoice_1, invoice_2 = create_list(:invoice, 2)
    transaction_1, transaction_2, transaction_3 = create_list(:transaction, 3, invoice: invoice_1)
    transaction_4 = create(:transaction, invoice: invoice_2)
    get "/api/v1/transactions/find_all?invoice_id=#{transaction_2.invoice_id}"

    expect(response).to be_success

    transactions = JSON.parse(response.body)
    expect(transactions).to be_instance_of(Array)
    expect(transactions.count).to eq(3)
  end

  it 'finds all transactions by credit_card_number parameter' do
    transaction_1, transaction_2, transaction_3 = create_list(:transaction, 3, credit_card_number: 235234)
    transaction_4 = create(:transaction, credit_card_number: 131313)

    get "/api/v1/transactions/find_all?credit_card_number=#{transaction_2.credit_card_number}"

    expect(response).to be_success

    transactions = JSON.parse(response.body)
    expect(transactions).to be_instance_of(Array)
    expect(transactions.count).to eq(3)
  end

  it 'finds all transactions by result parameter' do
    transaction_1, transaction_2, transaction_3 = create_list(:transaction, 3, result: 'failed')
    transaction_4 = create(:transaction)

    get "/api/v1/transactions/find_all?result=#{transaction_2.result}"

    expect(response).to be_success

    transactions = JSON.parse(response.body)
    expect(transactions).to be_instance_of(Array)
    expect(transactions.count).to eq(3)
  end

  it 'finds one transaction by case insensitive result parameter' do
    transaction_1, transaction_2, transaction_3 = create_list(:transaction, 3, result: 'failed')
    transaction_4 = create(:transaction)

    get "/api/v1/transactions/find_all?result=SUCcESs"

    expect(response).to be_success

    transactions = JSON.parse(response.body)
    expect(transactions).to be_instance_of(Array)
    expect(transactions.count).to eq(1)
  end

  it 'finds all transactions by created_at parameter' do
    created_at = "2017-03-14 12:12:12 UTC"
    transaction_1, transaction_2, transaction_3 = create_list(:transaction, 3)
    transaction_4 = create(:transaction, created_at: created_at)

    get "/api/v1/transactions/find_all?created_at=#{created_at}"

    expect(response).to be_success

    transactions = JSON.parse(response.body)
    expect(transactions).to be_instance_of(Array)
    expect(transactions.count).to eq(1)
  end

  it 'finds one transaction by updated_at parameter' do
    updated_at = "2017-03-14 12:12:12 UTC"
    transaction_1, transaction_2, transaction_3 = create_list(:transaction, 3)
    transaction_4 = create(:transaction, updated_at: updated_at)

    get "/api/v1/transactions/find_all?updated_at=#{updated_at}"

    expect(response).to be_success

    transactions = JSON.parse(response.body)
    expect(transactions).to be_instance_of(Array)
    expect(transactions.count).to eq(1)
  end

  it 'returns 404 error if find params are invalid' do
    get "/api/v1/transactions/find?duck=goose"

    expect(response).to_not be_success
    expect(response.status).to eq(404)
  end

  it 'returns 404 error if find all params are invalid' do
    get "/api/v1/transactions/find_all?duck=goose"

    expect(response).to_not be_success
    expect(response.status).to eq(404)
  end

  it 'returns random transaction' do
    transaction_1, transaction_2, transaction_3 = create_list(:transaction, 3)

    get "/api/v1/transactions/random"

    expect(response).to be_success

    transaction = JSON.parse(response.body)
    expect(transaction[:id])
    expect(transaction[:invoice_id])
    expect(transaction[:credit_card_number])
    expect(transaction[:created_at])
    expect(transaction[:updated_at])
    expect(transaction[:result])
  end
end
