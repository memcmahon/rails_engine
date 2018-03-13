class Merchant < ApplicationRecord
  validates_presence_of :name

  has_many :invoices
  has_many :items

  scope :find_by_name, lambda { |name, value| where("lower(#{name}) = ?", value.downcase.gsub("_", " ")).first }
  scope :find_all_by_name, lambda { |name, value| where("lower(#{name}) = ?", value.downcase.gsub("_", " ")) }
end
