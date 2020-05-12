require 'rails_helper'

RSpec.describe 'As a visitor', type: :feature do
  describe 'pets edit page' do

    it 'has a form to edit the pets information' do

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

      visit "/pets/#{lucille.id}/edit"

      fill_in :name, with: "Lucy"
      fill_in :image, with: "https://www.wistv.com/resizer/OG31bWaZ8eZdQaS9hHTWYbzVyG4=/1200x600/arc-anglerfish-arc2-prod-raycom.s3.amazonaws.com/public/UIX6NOMHARHIPDOTDETOPCZBXE.jpg"
      fill_in :description, with: "Excellent pet for people with kids!"
      fill_in :age, with: 6
      fill_in :sex, with: "female"

      click_button "Update Pet"

      expect(current_path).to eq("/pets/#{lucille.id}")

      lucille.reload

      expect(lucille.name).to eq("Lucy")

      expect(lucille.description).to eq("Excellent pet for people with kids!")
    end
  end
end
