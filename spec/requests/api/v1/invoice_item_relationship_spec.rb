require 'rails_helper'

describe 'Invoice Items Relationship API' do
  it 'sends the invoice item invoice' do
    invoice = create(:invoice)
    invoice_item = create(:invoice_item, invoice: invoice)

    get "/api/v1/invoice_items/#{invoice_item.id}/invoice"

    expect(response).to be_success

    invoice = JSON.parse(response.body)["invoice"]
  end
end
