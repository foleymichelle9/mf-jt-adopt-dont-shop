require 'rails_helper'

RSpec.describe 'As a visitor' do
  describe 'pets show page' do

    it 'shows all the info for the pet with that id' do

      shelter1 = Shelter.create(name: "Pet House",
                                address: "12 Main St.",
                                city: "Denver",
                                state: "Colorado",
                                zip: "80001")

      lucille = shelter1.pets.create!(image: 'https://justsomething.co/wp-content/uploads/2014/08/pitbull-photos-13.jpg',
                                      name: "Lucille",
                                      age: 3,
                                      description: "Lovable pitbull",
                                      sex: "female")

      george = shelter1.pets.create!(image: 'https://i1.wp.com/puppytoob.com/wp-content/uploads/2017/05/Golden-retriever.jpg?resize=752%2C443',
                                     name: "George",
                                     age: 4,
                                     sex: "Male")

      visit "/pets/#{lucille.id}"

      expect(page).to have_content(lucille.name)
      expect(page).to have_content(lucille.age)
      expect(page).to have_css("img[src*= '#{lucille.image}']")
      expect(page).to have_content(lucille.sex)
      expect(page).to have_content(lucille.description)
      #expect(page).to have_content(lucille.status)

      expect(page).to_not have_content(george.name)

    end
    it 'has a link to update that pet' do
      shelter1 = Shelter.create(name: "Pet House",
                                address: "12 Main St.",
                                city: "Denver",
                                state: "Colorado",
                                zip: "80001")

      lucille = shelter1.pets.create!(image: 'https://justsomething.co/wp-content/uploads/2014/08/pitbull-photos-13.jpg',
                                      name: "Lucille",
                                      age: 3,
                                      description: "Lovable pitbull",
                                      sex: "female")

      visit "/pets/#{lucille.id}"

      click_link "Update Pet"

      expect(current_path).to eq("/pets/#{lucille.id}/edit")
    end

    it 'has a link to change the adoptable status to pending' do
      shelter1 = Shelter.create(name: "Pet House",
                                address: "12 Main St.",
                                city: "Denver",
                                state: "Colorado",
                                zip: "80001")

      lucille = shelter1.pets.create!(image: 'https://justsomething.co/wp-content/uploads/2014/08/pitbull-photos-13.jpg',
                                      name: "Lucille",
                                      age: 3,
                                      status: true,
                                      description: "Lovable pitbull",
                                      sex: "female")

      visit "/pets/#{lucille.id}"

      expect(lucille.adoptable_status).to eq("Adoptable!")

      click_link "Adopt this Pet!"

      lucille.reload
      expect(current_path).to eq("/pets/#{lucille.id}")
      expect(lucille.adoptable_status).to eq("Pending")
    end

    it 'has a link to change the pending status to adoptable' do
      shelter1 = Shelter.create(name: "Pet House",
                                address: "12 Main St.",
                                city: "Denver",
                                state: "Colorado",
                                zip: "80001")

      lucille = shelter1.pets.create!(image: 'https://justsomething.co/wp-content/uploads/2014/08/pitbull-photos-13.jpg',
                                      name: "Lucille",
                                      age: 3,
                                      status: false,
                                      description: "Lovable pitbull",
                                      sex: "female")

      visit "/pets/#{lucille.id}"

      expect(lucille.adoptable_status).to eq("Pending")

      click_link "Change status to Adoptable"

      lucille.reload
      expect(current_path).to eq("/pets/#{lucille.id}")
      expect(lucille.adoptable_status).to eq("Adoptable!")
    end
  end
end
