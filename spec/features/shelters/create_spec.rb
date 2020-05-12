require 'rails_helper'

RSpec.describe 'As a visitor' do
  describe 'new shelter page' do
    it 'can create a new shelter in the system' do

      visit 'shelters/new'

      fill_in :name, with: "Best Companions"
      fill_in :address, with: "131 Pit Bull Lane"
      fill_in :city, with: "Boston"
      fill_in :state, with: "Massachusetts"
      fill_in :zip, with: "01010"
      click_on "Create Shelter"

      shelter = Shelter.last

      expect(current_path).to eq("/shelters")
      expect(page).to have_content(shelter.name)
    end

    it 'shows a message when the name of a shelter is already in the system' do

      shelter1 = Shelter.create(name: "Best Companions", address: "847", city: "cjcj", state: "lkd", zip: "8498")

      visit "/shelters/new"

      fill_in :name, with: "Best Companions"
      fill_in :address, with: "131 Pit Bull Lane"
      fill_in :city, with: "Boston"
      fill_in :state, with: "Massachusetts"
      fill_in :zip, with: "01010"

      click_on "Create Shelter"

      expect(page).to have_content("Name is already in the system")
    end

    it 'shows an error message when all fields on form are not filled in' do

      visit "/shelters/new"

      fill_in :name, with: "Best Companions"

      fill_in :city, with: "Boston"
      fill_in :state, with: "Massachusetts"
      fill_in :zip, with: "01010"

      click_on "Create Shelter"

      #expect(current_path).to eq("/shelters/new")
      expect(page).to have_content("All fields are required")
    end
  end
end
