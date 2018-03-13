class ItemSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :unit_price, :merchant_id

  has_many :invoice_items
  belongs_to :merchant
end
