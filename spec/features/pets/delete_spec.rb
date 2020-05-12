require 'rails_helper'

RSpec.describe 'As a visitor' do
  describe 'pet delete function on pet show page' do
    it 'has a link to delete pet' do
      shelter1 = Shelter.create(name: "Pet House",
                                 address: "12 Main St.",
                                 city: "Denver",
                                 state: "Colorado",
                                 zip: "80001")

      lucille = shelter1.pets.create!(image: 'https://justsomething.co/wp-content/uploads/2014/08/pitbull-photos-13.jpg',
                                     name: "Lucille",
                                     age: 3,
                                     sex: "female")

      george = shelter1.pets.create!(image: 'https://i1.wp.com/puppytoob.com/wp-content/uploads/2017/05/Golden-retriever.jpg?resize=752%2C443',
                                     name: "George",
                                     age: 4,
                                     sex: "Male")

      visit "/pets"
      expect(page).to have_content(lucille.name)

      visit "/pets/#{lucille.id}"

      click_link "Delete Pet"

      expect(current_path).to eq("/pets")
      expect(page).to_not have_content(lucille.name)

    end
  end
end
