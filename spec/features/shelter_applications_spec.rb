require "rails_helper"

RSpec.describe "From a shelter show page", type: feature do
  before(:each) do


it "cannot delete a shelter with pending pet statuses" do

  @shelter2 = Shelter.create(name: "Love Pets",
                             address: "1111 Dog St.",
                             city: "Los Angeles",
                             state: "California",
                             zip: "90210")

  @george = @shelter2.pets.create!(image: 'https://i1.wp.com/puppytoob.com/wp-content/uploads/2017/05/Golden-retriever.jpg?resize=752%2C443',
                                  name: "George",
                                  age: 4,
                                  status: false,
                                  sex: "Male")
    end

    visit "/shelters/#{shelter2.id}"

    click_link 'Delete Shelter'

    expect(page).to have_content("Pet pending adoption, shelter can not be deleted.")
  end
end
