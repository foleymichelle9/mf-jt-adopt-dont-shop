require 'rails_helper'

RSpec.describe 'favorite indicator in nav bar' do
  before(:each) do
    @shelter1 = Shelter.create(name: "Pet House",
                              address: "12 Main St.",
                              city: "Denver",
                              state: "Colorado",
                              zip: "80001")

    @lucille = @shelter1.pets.create!(image: 'https://justsomething.co/wp-content/uploads/2014/08/pitbull-photos-13.jpg',
                                    name: "Lucille",
                                    age: 3,
                                    status: false,
                                    description: "Lovable pitbull",
                                    sex: "female")
  end

  it 'displays the total number of pets favorited in the nav bar' do

    visit "/pets/#{@lucille.id}"
    expect(page).to have_content("Number of pets favorited: 0")

    click_button "Add to Favorites"

    expect(page).to have_content("Number of pets favorited: 1")
  end

  it 'I can only favorite a pet once' do

    visit "/pets/#{@lucille.id}"
    expect(page).to have_content("Number of pets favorited: 0")

    click_button "Add to Favorites"

    expect(page).to have_content("Number of pets favorited: 1")

    click_button "Add to Favorites"

    expect(page).to have_content("You have already favorited #{@lucille.name}")
    expect(page).to have_content("Number of pets favorited: 1")
  end
end
