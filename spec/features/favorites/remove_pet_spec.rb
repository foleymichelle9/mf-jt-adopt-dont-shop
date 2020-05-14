require "rails_helper"

RSpec.describe "remove pet from favorites" do
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

  it "Pets show page has a button to remove pet from favorites" do

    visit "/pets/#{@lucille.id}"
    click_button "Add to Favorites"

    expect(page).to have_content("Number of pets favorited: 1")

    click_button "Remove #{@lucille.name} from Favorites"

    expect(page).to have_content("You have removed #{@lucille.name} from favorites")
    expect(page).to have_content("Number of pets favorited: 0")
  end
end
