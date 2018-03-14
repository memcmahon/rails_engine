class ItemInvoiceItemSerializer < ActiveModel::Serializer
  has_many :invoice_items
end
