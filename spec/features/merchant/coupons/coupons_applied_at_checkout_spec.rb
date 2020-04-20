require 'rails_helper'

RSpec.describe 'When I view my cart as a user' do
  describe 'Any merchant coupons are automatically applied' do
    before(:each) do
      @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)

      @tire = @meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
      @paper = @meg.items.create(name: "Lined Paper", description: "Great for writing on!", price: 20, image: "https://cdn.vertex42.com/WordTemplates/images/printable-lined-paper-wide-ruled.png", inventory: 3)
      @pencil = @meg.items.create(name: "Yellow Pencil", description: "You can write on paper with it!", price: 2, image: "https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg", inventory: 100)
      @coupon1 = @meg.coupons.create!(name: "20% off 5 Items", percent_off: 20, quantity_required: 5)


      @user = User.create!( email_address: 'user1@example.com', password: 'password', role: 'default', name: 'User 1', street_address: '123 Example St', city: 'Userville', state: 'State 1', zip_code: '12345')
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    end

      it "shows the corrected totals after coupons are applied" do
        visit "/items/#{@tire.id}"
        click_on "Add To Cart"

        visit "/cart"
          within "#item-quantity-#{@tire.id}" do
            4.times do
              click_link "+"
            end
          end

          expect(page).to_not have_content("$500.00")
          expect(page).to have_content("$400.00")
      end
    end
    after(:each) do
      User.destroy_all
      Merchant.destroy_all
    end
end
