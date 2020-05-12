require 'rails_helper'

RSpec.describe 'As a visitor' do
  describe 'shelter show page' do

    before(:each) do
      @shelter1 = Shelter.create(name: "Pet House",
                                 address: "12 Main St.",
                                 city: "Denver",
                                 state: "Colorado",
                                 zip: "80001")

      @shelter2 = Shelter.create(name: "Love Pets",
                                 address: "1111 Dog St.",
                                 city: "Los Angeles",
                                 state: "California",
                                 zip: "90210")

      @shelter3 = Shelter.create(name: "Dogs Rock",
                                 address: "Bark Rd.",
                                 city: "Boulder",
                                 state: "Colorado",
                                 zip: "81111")

      @lucille = @shelter1.pets.create!(image: 'https://justsomething.co/wp-content/uploads/2014/08/pitbull-photos-13.jpg',
                                     name: "Lucille",
                                     age: 3,
                                     sex: "female")

      @george = @shelter1.pets.create!(image: 'https://i1.wp.com/puppytoob.com/wp-content/uploads/2017/05/Golden-retriever.jpg?resize=752%2C443',
                                     name: "George",
                                     age: 4,
                                     sex: "Male")

    end

    it 'can see the shelter with that id and all its information' do

      visit "/shelters/#{@shelter1.id}"

      expect(page).to have_content(@shelter1.name)
      expect(page).to have_content(@shelter1.address)
      expect(page).to have_content(@shelter1.city)
      expect(page).to have_content(@shelter1.state)
      expect(page).to have_content(@shelter1.zip)

      expect(page).to_not have_content(@shelter2.name)

    end

    it 'has a link to update shelter' do

      visit "/shelters/#{@shelter1.id}"

      click_button "Update Shelter"
      expect(current_path).to eq("/shelters/#{@shelter1.id}/edit")
    end

    it 'has a link to delete shelter' do

      visit "/shelters/#{@shelter1.id}"

      click_button "Delete Shelter"

      expect(current_path).to eq("/shelters")
      expect(page).to_not have_content(@shelter1.name)
    end

    it 'has a link to that shelters pets page' do

      visit "/shelters/#{@shelter1.id}"

      click_link "Pet's at Shelter"
      expect(current_path).to eq("/shelters/#{@shelter1.id}/pets")
      expect(page).to have_content(@lucille.name)
      expect(page).to have_content(@george.name)
    end

  end
end
