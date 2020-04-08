require 'rails_helper'

RSpec.describe "As a user (role 1)", type: :feature do
  describe "default (role 1)" do
    it "can see profile page and logout links without login or register links" do
      default_user = User.create(
        email_address: "user1@example.com",
        password: "password",
        role: "default",
        user_detail: UserDetail.new(
          name: "User 1",
          street_address: "123 Example St",
          city: "Userville",
          state: "State 1",
          zip_code: "12345"
        )
      )

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(default_user)

      visit "/profile"

      expect(page).to have_content("Logged in as #{default_user.user_detail.name}")

      click_link("Home")
      expect(current_path).to eq(root_path)

      click_link("All Merchants")
      expect(current_path).to eq(merchants_path)

      click_link("All Items")
      expect(current_path).to eq(items_path)

      click_link("Cart: 0")
      expect(current_path).to eq(cart_path)

      click_link("Profile")
      expect(current_path).to eq('/profile')

      click_link("Logout")
      expect(current_path).to eq(root_path)
    end
  end
  describe "as a merchant (role 2)" do
    it "can see same links as regular user plus link to merchant dashboard" do
      merchant_user = User.create(
        email_address: "user1@example.com",
        password: "password",
        role: "merchant",
        user_detail: UserDetail.new(
          name: "User 1",
          street_address: "123 Example St",
          city: "Userville",
          state: "State 1",
          zip_code: "12345"
        )
      )

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant_user)

      visit "/"

      click_link("Home")
      expect(current_path).to eq(root_path)

      click_link("All Merchants")
      expect(current_path).to eq(merchants_path)

      click_link("All Items")
      expect(current_path).to eq(items_path)

      click_link("Cart: 0")
      expect(current_path).to eq(cart_path)

      click_link("Profile")
      expect(current_path).to eq('/profile')

      click_link("Logout")
      expect(current_path).to eq(root_path)

      click_link("Dashboard")
      expect(current_path).to eq(merchant_dashboard_path)
    end
  end
end
