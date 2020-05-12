require 'rails_helper'

RSpec.describe 'As a visitor' do
  describe 'shelter pets new page' do

    it 'has a form to fill out info for a new pet in that shelter' do

      shelter1 = Shelter.create(name: "Pet House",
                                 address: "12 Main St.",
                                 city: "Denver",
                                 state: "Colorado",
                                 zip: "80001")

      visit "/shelters/#{shelter1.id}/pets/new"

      fill_in :image, with: "https://media.istockphoto.com/photos/black-lab-picture-id489205728?k=6&m=489205728&s=612x612&w=0&h=2hr27DW-DpJgOaHQU-6dvBQO3nOa3NHOtVzcFpez7sA="
      fill_in :name, with: "Sparky"
      fill_in :description, with: "Loveable black lab!"
      fill_in :age, with: 5
      fill_in :sex, with: "male"

      click_button "Create Pet"

      pet = Pet.last

      expect(current_path).to eq("/shelters/#{shelter1.id}/pets")

      expect(page).to have_content(pet.name)

    end
  end
end
