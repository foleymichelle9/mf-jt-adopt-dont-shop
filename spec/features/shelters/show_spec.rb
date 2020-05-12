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

    it 'has a list of all reviews for that shelter' do

      review1 = @shelter1.reviews.create(title: "Love this place!", rating: 5, content: "This shelter has the nicest employees and the most well-behaved dogs!")
      review2 = @shelter1.reviews.create(title: "Not a fan of this place.", rating: 1, content: "The dog I adopted from this shelter bit me!", image: "https://images-prod.healthline.com/hlcmsresource/images/imce/animal-bites-finger_thumb.jpg")
      review3 = @shelter1.reviews.create(title: "Favorite shelter by far!", rating: 5, content: "These people love animals!")

      visit "/shelters/#{@shelter1.id}"

      expect(page).to have_content("All reviews for #{@shelter1.name}:")

      within "#review-#{review1.id}" do
        expect(page).to have_content("#{review1.title}")
        expect(page).to have_content("#{review1.rating}")
        expect(page).to have_content("#{review1.content}")
      end

      within "#review-#{review2.id}" do
        expect(page).to have_content("#{review2.title}")
        expect(page).to have_content("#{review2.rating}")
        expect(page).to have_content("#{review2.content}")
      end

      within "#review-#{review3.id}" do
        expect(page).to have_content("#{review3.title}")
        expect(page).to have_content("#{review3.rating}")
        expect(page).to have_content("#{review3.content}")
      end
    end

    it 'has a link to add a new review for this shelter' do

      visit "/shelters/#{@shelter1.id}"

      click_link "Add Review"

      expect(current_path).to eq("/shelters/#{@shelter1.id}/reviews/new")
    end

    it 'has a link next to each review to edit that review' do

      review1 = @shelter1.reviews.create(title: "Love this place!", rating: 5, content: "This shelter has the nicest employees and the most well-behaved dogs!")
      review2 = @shelter1.reviews.create(title: "Not a fan of this place.", rating: 1, content: "The dog I adopted from this shelter bit me!", image: "https://images-prod.healthline.com/hlcmsresource/images/imce/animal-bites-finger_thumb.jpg")
      review3 = @shelter1.reviews.create(title: "Favorite shelter by far!", rating: 5, content: "These people love animals!")

      visit "/shelters/#{@shelter1.id}"

      within "#review-#{review1.id}" do
        click_link "Edit Review"
      end

      expect(current_path).to eq("/reviews/#{review1.id}/edit")
    end
  end
end
