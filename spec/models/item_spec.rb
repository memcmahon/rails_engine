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

    it "should return item with most sales" do
      item_1, item_2 = create(:item, 2)
      invoice = create(:invoice)
      invoice_item_1, invoice_item_2 = create(:invoice_item, 2, item: item_1, invoice: invoice)
      invoice_item_3 = create(:invoice_item, quantity: 12, item: item_2, invoice: invoice)

      expect(Item.ranked_by_sale(1)[0]).to eq(item_2)
    end
  end
end
