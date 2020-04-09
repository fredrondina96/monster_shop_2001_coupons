require 'rails_helper'

RSpec.describe "As a signed in user, when I visit /profile", type: :feature do
    it "there is a link I can click to edit profile information" do
      user1 = User.new(
        email_address: "user1@example.com",
        password: "password",
        user_detail: UserDetail.new(
          name: "User 1",
          street_address: "123 Example St",
          city: "Userville",
          state: "State 1",
          zip_code: "12345"
        )
      )
      user1.save
      visit '/login'
      fill_in "Email Address", with: user1.email_address
      fill_in "Password", with: user1.password
      click_button "Login"

      visit "/profile"
      expect(page).to have_link("Edit Profile")
      click_link("Edit Profile")

      fill_in "user_detail_attributes[name]", with: "George"
      fill_in "user_detail_attributes[street_address]", with: "123 fake street"
      fill_in "user_detail_attributes[city]", with: "Denver"
      fill_in "user_detail_attributes[state]", with: "CO"
      fill_in "user_detail_attributes[zip_code]", with: "80205"

      click_button "Update Info"

      expect(current_path).to eq("/profile")
      expect(page).to have_content("Your information has been updated.")
      expect(page).to have_content("George")
      expect(page).to have_content("123 fake street")
      expect(page).to have_content("Denver")
      expect(page).to have_content("CO")
      expect(page).to have_content("80205")
      expect(page).to_not have_content("123 Example St")
      expect(page).to_not have_content("User 1")
    end
end
