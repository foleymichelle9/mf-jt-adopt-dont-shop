require 'rails_helper'

RSpec.describe 'Shelter reviews edit page' do
  it 'has a form to edit the review' do

    shelter1 = Shelter.create(name: "Pet House",
                                 address: "12 Main St.",
                                 city: "Denver",
                                 state: "Colorado",
                                 zip: "80001")

    review1 = shelter1.reviews.create(title: "Love this place!", rating: 5, content: "This shelter has the nicest employees and the most well-behaved dogs!")

    visit "/shelters/#{shelter1.id}"
    expect(page).to have_content("Love this place!")

    visit "/reviews/#{review1.id}/edit"

    fill_in :image, with: "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcR_kZdgps2QwraWJyKH5IAX7J4v84mAZXVlYBQ2JfPXg6XgdHSn&usqp=CAU"
    fill_in :title, with: "Beautiful Dogs!"
    fill_in :rating, with: 5
    fill_in :content, with: "Wonderful Place!"

    click_button "Update Review"

    expect(current_path).to eq("/shelters/#{shelter1.id}")

    expect(page).to have_content("Beautiful Dogs!")
    expect(review1.rating).to eq(5)
    
  end
end
