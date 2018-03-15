require 'rails_helper'

describe 'Invoice Items Relationship API' do
  it 'sends the invoice item invoice' do
    invoice = create(:invoice)
    invoice_item = create(:invoice_item, invoice: invoice)

    get "/api/v1/invoice_items/#{invoice_item.id}/invoice"

    expect(response).to be_success

    returned_invoice = JSON.parse(response.body)

    expect(returned_invoice["id"]).to eq(invoice.id)
  end

  it 'sends the invoice item invoice' do
    item = create(:item)
    invoice_item = create(:invoice_item, item: item)

    get "/api/v1/invoice_items/#{invoice_item.id}/item"

    expect(response).to be_success

    returned_item = JSON.parse(response.body)
    expect(returned_item["id"]).to eq(item.id)
  end
end
