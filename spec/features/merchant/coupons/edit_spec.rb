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
    expect(page).to have_link("Edit Coupon")
    click_link("Edit Coupon")
    expect(current_path).to eq("/merchant/coupons/#{@coupon1.id}/edit")

    fill_in :name, with: "25% off of 50"
    fill_in :percent_off, with: 25
    fill_in :quantity_required, with: 50
    click_button "Update Coupon"

    expect(current_path).to eq("/merchant")
    expect(page).to_not have_content("20% off 5 Items")
    expect(page).to have_content("25% off of 50")
end

  it "I can only edit coupons with valid attributes" do
    visit "/merchant/"

    click_link("Edit Coupon")
    expect(current_path).to eq("/merchant/coupons/#{@coupon1.id}/edit")

    fill_in :name, with: ""
    fill_in :percent_off, with: "-99"
    fill_in :quantity_required, with: "-7"
    click_button "Update Coupon"

    expect(page).to have_content("Name can't be blank, Percent off must be greater than 0, and Quantity required must be greater than or equal to 0")
end

  after(:each) do
    User.destroy_all
    Merchant.destroy_all
  end
end
