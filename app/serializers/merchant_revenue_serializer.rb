class MerchantRevenueSerializer < ActiveModel::Serializer
  attributes :revenue

  def revenue
    (object.revenue(@instance_options[:created_at_search]) / 100.0).to_s
  end
end
