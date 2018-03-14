require 'rails_helper'

describe Item, type: :model do
  describe "validations" do
    it { should validate_presence_of(:name)}
    it { should validate_presence_of(:description)}
    it { should validate_presence_of(:unit_price)}
    it { should validate_presence_of(:merchant_id)}
  end

  describe "relationships" do
    it { should belong_to(:merchant)}
    it { should have_many(:invoice_items)}
    it { should have_many(:invoices)}
  end

  describe "Analytics" do
    it "should return best day for item sales" do
      item = create(:item)
      invoice_1 = create(:invoice, created_at: "2017-03-14 12:12:12 UTC")
      invoice_2 = create(:invoice, created_at: "2017-09-14 12:12:12 UTC")
      invoice_item_1 = create(:invoice_item, quantity: 3, invoice: invoice_2, item: item)
      invoice_item_2 = create(:invoice_item, quantity: 2, invoice: invoice_1, item: item)

      expect(item.best_day).to eq(invoice_2.created_at)
    end
  end
end
