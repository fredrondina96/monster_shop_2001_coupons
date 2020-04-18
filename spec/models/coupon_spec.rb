require 'rails_helper'

describe Coupon, type: :model do

  describe "validations" do
     it { should validate_presence_of :name }
     it { should validate_presence_of :quantity_required }
     it { should validate_presence_of :percent_off }
  end

  describe "relationships" do
    it {should belong_to :merchant}
  end

end
