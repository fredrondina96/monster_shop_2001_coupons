require "rails_helper"

RSpec.describe "As a merchant user", type: :feature do
  before(:each) do
    @merchant1 = User.create!( email_address: 'merchant@example.com', password: 'password', role: 2, name: 'merchant', street_address: '123 admin St', city: 'adminville', state: 'State 5', zip_code: '54321')

    @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
    @meg.users << @merchant1

    @coupon1 = @meg.coupons.create!(name: "20% off 5 Items", percent_off: 20, quantity_required: 5)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@merchant1)
  end

  it "I can edit coupons I have created" do
    visit "/merchant/"

    expect(page).to have_content("Current Coupons")
    expect(page).to have_content(@coupon1.name)
    expect(page).to have_link("Delete Coupon")

    click_link ("Delete Coupon")
    expect(current_path).to eq("/merchant")
    expect(page).to have_content("Coupon Deleted")
    expect(page).to_not have_content("#{@coupon1.name}")
end

  after(:each) do
    User.destroy_all
    Merchant.destroy_all
  end
end
