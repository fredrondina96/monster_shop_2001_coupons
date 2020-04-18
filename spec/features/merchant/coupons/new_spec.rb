require "rails_helper"

RSpec.describe "As a merchant user", type: :feature do
  before(:each) do
    @merchant1 = User.create!( email_address: 'merchant@example.com', password: 'password', role: 2, name: 'merchant', street_address: '123 admin St', city: 'adminville', state: 'State 5', zip_code: '54321')

    @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
    @brian = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)
    @meg.users << @merchant1

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@merchant1)
  end

  it "I can create coupons from my dashboard" do
    visit "/merchant/"

    expect(page).to have_link("New Coupon")
    click_link("New Coupon")
    expect(current_path).to eq("/merchant/coupons/new")
end

  after(:each) do
    User.destroy_all
    Merchant.destroy_all
  end
end
