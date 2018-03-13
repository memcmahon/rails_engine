require 'rails_helper'

describe 'Customers API' do
  it 'sends a list of customers' do
    create_list(:customer, 5)

    get "/api/v1/customers.json"

    expect(response).to be_success

    customers = JSON.parse(response.body)
    expect(customers.count).to eq(5)
  end

  it 'sends one customer by id' do
    create_list(:customer, 5)
    id = create(:customer).id

    get "/api/v1/customers/#{id}.json"

    expect(response).to be_success

    customer = JSON.parse(response.body)
    expect(customer["id"]).to eq(id)
  end
end
