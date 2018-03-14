class MerchantInvoicesSerializer < ActiveModel::Serializer
  has_many :invoices
end
