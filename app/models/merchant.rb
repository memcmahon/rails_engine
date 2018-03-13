class Merchant < ApplicationRecord
  validates_presence_of :name

  scope :find_by_name, lambda { |name, value| where("lower(#{name}) = ?", value.downcase.gsub("_", " ")).first }
  scope :find_all_by_name, lambda { |name, value| where("lower(#{name}) = ?", value.downcase.gsub("_", " ")) }
  # scope :find_by_created_at, lambda { |created_at, value| where("created_at = ?", value).first }
  # scope :find_all_by_created_at, lambda { |created_at, value| where("created_at = ?", value) }
  # scope :find_by_updated_at, lambda { |updated_at, value| where("updated_at = ?", value).first }
  # scope :find_all_by_updated_at, lambda { |updated_at, value| where("updated_at = ?", value) }
end
