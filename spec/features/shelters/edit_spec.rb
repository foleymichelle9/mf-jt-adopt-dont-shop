require 'rails_helper'

RSpec.describe 'As a visitor' do
  describe 'shelter edit page' do
    it 'has a form to update all of shelters information' do

      shelter1 = Shelter.create(name: "Pet House",
                                 address: "12 Main St.",
                                 city: "Denver",
                                 state: "Colorado",
                                 zip: "80001")

      visit "/shelters/#{shelter1.id}"

      expect(page).to have_content(shelter1.name)

      click_button "Update Shelter"

      fill_in :name, with: "Love All Animals"
      fill_in :address, with: "222 Cats Dr."
      fill_in :city, with: "New York City"
      fill_in :state, with: "New York"
      fill_in :zip, with: "02222"

      click_button "Update Shelter"

      expect(current_path).to eq("/shelters/#{shelter1.id}")

      expect(page).to have_content("Love All Animals")

    end

    it 'has a form to update all of shelters information' do

      shelter1 = Shelter.create(name: "Pet House",
                                 address: "12 Main St.",
                                 city: "Denver",
                                 state: "Colorado",
                                 zip: "80001")

      visit "/shelters/#{shelter1.id}"

      expect(page).to have_content("Pet House")

      click_button "Update Shelter"

      fill_in :name, with: "Love All Animals"
      fill_in :address, with: "222 Cats Dr."
      fill_in :city, with: "New York City"
      fill_in :zip, with: "02222"

      click_button "Update Shelter"

      expect(page).to have_content("State can't be blank")
    end
  end
end
