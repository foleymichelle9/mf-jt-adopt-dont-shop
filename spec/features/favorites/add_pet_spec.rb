require 'rails_helper'

RSpec.describe 'favorite indicator in nav bar' do
  it 'displays the total number of pets favorited in the nav bar' do
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
    expect(page).to have_content("Number of pets favorited: 0")

    click_button "Add to Favorites"

    expect(page).to have_content("Number of pets favorited: 1")

  end
end
