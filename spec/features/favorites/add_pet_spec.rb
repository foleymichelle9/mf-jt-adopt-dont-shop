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

  it "When pet is favorited, favorite button no longer appears on pet show page" do

    visit "/pets/#{@lucille.id}"
    click_button "Add to Favorites"
    expect(page).to have_content("Number of pets favorited: 1")
    expect(page).to_not have_button("Add to Favorites")
  end
end

#
# As a visitor
# After I've favorited a pet
# When I visit that pet's show page
# I no longer see a link to favorite that pet
# But I see a link to remove that pet from my favorites
# When I click that link
# A delete request is sent to "/favorites/:pet_id"
# And I'm redirected back to that pets show page where I can see a flash message indicating that the pet was removed from my favorites
# And I can now see a link to favorite that pet
# And I also see that my favorites indicator has decremented by 1
