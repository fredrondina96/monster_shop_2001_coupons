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

    fill_in :name, with: "20% off 5 items"
    fill_in :percent_off, with: 20
    fill_in :quantity_required, with: 5
    click_button "Create Coupon"

    expect(current_path).to eq("/merchant")
    expect(page).to have_content("Current Coupons")
    expect(page).to have_content("20% off 5 items")
end

it "I can create coupons but only with valid attributes" do
  visit "/merchant/"

  expect(page).to have_link("New Coupon")
  click_link("New Coupon")
  expect(current_path).to eq("/merchant/coupons/new")

  fill_in :name, with: "30% off 10 items"
  fill_in :percent_off, with: "-10"
  fill_in :quantity_required, with: 5
  click_button "Create Coupon"

  expect(page).to have_content("Percent off must be greater than 0")

  fill_in :name, with: ""
  fill_in :percent_off, with: 10
  fill_in :quantity_required, with: "-3"
  click_button "Create Coupon"

  expect(page).to have_content("Name can't be blank and Quantity required must be greater than or equal to 0")
end

  after(:each) do
    User.destroy_all
    Merchant.destroy_all
  end
end
