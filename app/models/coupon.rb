class Coupon < ApplicationRecord

  validates_presence_of :name, :quantity_required, :percent_off

end
