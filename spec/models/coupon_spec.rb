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

  describe "model methods" do
    it "discount" do
      @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @coupon1 = @meg.coupons.create!(name: "20% off 5 Items", percent_off: 20, quantity_required: 5)
      
      expect(@coupon1.discount).to eq(0.8)
    end
  end

end
