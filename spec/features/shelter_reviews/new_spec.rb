require 'rails_helper'

RSpec.describe 'As a visitor' do
  describe 'shelter reviews new page' do
    it 'has a form to create a new review for that shelter' do

      shelter1 = Shelter.create(name: "Pet House",
                                 address: "12 Main St.",
                                 city: "Denver",
                                 state: "Colorado",
                                 zip: "80001")

      visit "/shelters/#{shelter1.id}/reviews/new"

      fill_in :image, with: "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcR_kZdgps2QwraWJyKH5IAX7J4v84mAZXVlYBQ2JfPXg6XgdHSn&usqp=CAU"
      fill_in :title, with: "This shelter is amazing!"
      fill_in :rating, with: 4
      fill_in :content, with: "All of the employees went out of there way to make sure
      that we found the perfect dog to be the newest member of our family."

      click_button "Create Review"

      review = Review.last

      expect(current_path).to eq("/shelters/#{shelter1.id}")

      expect(page).to have_content("#{review.title}")
    end

    it 'will give an error message when the title is not filled in on the new review form' do
      shelter1 = Shelter.create(name: "Pet House",
                                 address: "12 Main St.",
                                 city: "Denver",
                                 state: "Colorado",
                                 zip: "80001")

      visit "/shelters/#{shelter1.id}/reviews/new"

      fill_in :image, with: "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcR_kZdgps2QwraWJyKH5IAX7J4v84mAZXVlYBQ2JfPXg6XgdHSn&usqp=CAU"
      fill_in :rating, with: 2
      fill_in :content, with: "All of the employees went out of there way to make sure
      that we found the perfect dog to be the newest member of our family."

      click_button "Create Review"

      expect(page).to have_content("All fields must be filled in.")
    end

    it 'will give an error message when the rating is not filled in on the new review form' do

      shelter1 = Shelter.create(name: "Pet House",
                                 address: "12 Main St.",
                                 city: "Denver",
                                 state: "Colorado",
                                 zip: "80001")

      visit "/shelters/#{shelter1.id}/reviews/new"

      fill_in :image, with: "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcR_kZdgps2QwraWJyKH5IAX7J4v84mAZXVlYBQ2JfPXg6XgdHSn&usqp=CAU"
      fill_in :title, with: "Ugly dogs!"
      fill_in :content, with: "All of the employees went out of there way to make sure
      that we found the perfect dog to be the newest member of our family."

      click_button "Create Review"

      #expect(current_path).to eq("/shelters/#{shelter1.id}/reviews/new")
      expect(page).to have_content("All fields must be filled in.")
    end

    it 'will give an error message when the content is not filled in on the new review form' do

      shelter1 = Shelter.create(name: "Pet House",
                                 address: "12 Main St.",
                                 city: "Denver",
                                 state: "Colorado",
                                 zip: "80001")

      visit "/shelters/#{shelter1.id}/reviews/new"

      fill_in :image, with: "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcR_kZdgps2QwraWJyKH5IAX7J4v84mAZXVlYBQ2JfPXg6XgdHSn&usqp=CAU"
      fill_in :title, with: "Beautiful Dogs!"
      fill_in :rating, with: 5

      click_button "Create Review"

      expect(page).to have_field(:image)
      expect(page).to have_field(:title)
      expect(page).to have_field(:rating)
      expect(page).to have_content("Please fill out a short message regarding your experience with #{shelter1.name}")
    end
  end
end
