class MerchantRevenueByDateSerializer < ActiveModel::Serializer
  attributes :total_revenue

  def total_revenue
    (object.revenue_by_date(@instance_options[:date]) / 100.0).to_s
  end
end
