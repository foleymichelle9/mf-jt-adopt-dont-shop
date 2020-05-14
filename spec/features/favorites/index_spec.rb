require 'rails_helper'

RSpec.describe 'Favorites index page' do
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
                                    status: false,
                                    sex: "female")

    @george = @shelter2.pets.create!(image: 'https://i1.wp.com/puppytoob.com/wp-content/uploads/2017/05/Golden-retriever.jpg?resize=752%2C443',
                                    name: "George",
                                    age: 4,
                                    status: false,
                                    sex: "Male")

    @bob = @shelter3.pets.create!(image: 'https://i.ytimg.com/vi/8FCSw-ST8hA/maxresdefault.jpg',
                                   name: "Bob",
                                   description: "Handsome Pug!",
                                   age: 2,
                                   sex: "male")

    @gladys = @shelter1.pets.create!(image: 'https://static.ddmcdn.com/en-us/apl/breedselector/images/breed-selector/dogs/breeds/dachshund-standard_01_lg.jpg',
                                   name: "Gladys",
                                   description: "A total terror!",
                                   age: 4,
                                   sex: "female")

    @maceo = @shelter2.pets.create!(image: 'https://upload.wikimedia.org/wikipedia/commons/0/00/1._DSC_0346_%2810096362833%29.jpg',
                                   name: "Maceo Parker",
                                   age: 10,
                                   description: "Best damn dog around!",
                                   sex: "male")

    @charlie = @shelter3.pets.create!(image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQ9IcR0ehgkAEqxBilz3GgsoQDLynWZILEPbmHQRPUrrdU0kXKV&usqp=CAU',
                                   name: "Charles",
                                   age: 6,
                                   description: "Your new best friend",
                                   sex: "male")
  end

  it 'shows all the pets I have favorited including pets name and image' do

    visit "/pets/#{@lucille.id}"
    click_button "Add to Favorites"
    expect(page).to have_content("Number of pets favorited: 1")

    visit "/pets/#{@george.id}"
    click_button "Add to Favorites"
    expect(page).to have_content("Number of pets favorited: 2")

    visit "/pets/#{@bob.id}"
    click_button "Add to Favorites"
    expect(page).to have_content("Number of pets favorited: 3")

    visit "/pets/#{@gladys.id}"
    click_button "Add to Favorites"
    expect(page).to have_content("Number of pets favorited: 4")

    visit "/favorites"

    expect(page).to have_content("#{@lucille.name}")
    expect(page).to have_css("img[src*= '#{@lucille.image}']")
    expect(page).to have_content("#{@george.name}")
    expect(page).to have_css("img[src*= '#{@george.image}']")
    expect(page).to have_content("#{@bob.name}")
    expect(page).to have_css("img[src*= '#{@bob.image}']")
    expect(page).to have_content("#{@gladys.name}")
    expect(page).to have_css("img[src*= '#{@gladys.image}']")

    expect(page).to_not have_content("#{@maceo.name}")
    expect(page).to_not have_content("#{@charlie.name}")
  end

  it "has a button next to each pet to remove that pet from favorites" do

    visit "/pets/#{@lucille.id}"
    click_button "Add to Favorites"
    expect(page).to have_content("Number of pets favorited: 1")

    visit "/pets/#{@george.id}"
    click_button "Add to Favorites"
    expect(page).to have_content("Number of pets favorited: 2")

    visit "/pets/#{@bob.id}"
    click_button "Add to Favorites"
    expect(page).to have_content("Number of pets favorited: 3")

    visit "/pets/#{@gladys.id}"
    click_button "Add to Favorites"
    expect(page).to have_content("Number of pets favorited: 4")

    visit "/favorites"
    within ".pet-#{@lucille.id}" do
      click_button "Remove from Favorites"
    end

    expect(page).to_not have_css("img[src*= '#{@lucille.image}']")
    expect(current_path).to eq("/favorites")
  end
end


#
# As a visitor
# When I have added pets to my favorites list
# And I visit my favorites page ("/favorites")
# Next to each pet, I see a button or link to remove that pet from my favorites
# When I click on that button or link to remove a favorite
# A delete request is sent to "/favorites/:pet_id"
# And I'm redirected back to the favorites page where I no longer see that pet listed
# And I also see that the favorites indicator has decremented by 1
