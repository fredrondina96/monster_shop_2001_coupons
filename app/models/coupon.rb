class Coupon < ApplicationRecord

  validates_presence_of :name, :quantity_required, :percent_off
  belongs_to :merchant
  validates_numericality_of :percent_off, greater_than: 0, only_integer: true
  validates_numericality_of :quantity_required, greater_than_or_equal_to: 0, only_integer: true

end
