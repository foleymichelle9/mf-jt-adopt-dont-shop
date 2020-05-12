require 'rails_helper'

RSpec.describe 'As a visitor' do
  describe 'shelters index page' do
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

      @lucille = @shelter3.pets.create!(image: 'https://justsomething.co/wp-content/uploads/2014/08/pitbull-photos-13.jpg',
                                        name: "Lucille",
                                        age: 9,
                                        sex: "female",
                                        status: false,
                                        description: "Lovable Pitbull")

      @george = @shelter3.pets.create!(image: 'https://i1.wp.com/puppytoob.com/wp-content/uploads/2017/05/Golden-retriever.jpg?resize=752%2C443',
                                       name: "George",
                                       age: 4,
                                       status: false,
                                       sex: "male")

      @bob = @shelter3.pets.create!(image: 'https://i.ytimg.com/vi/8FCSw-ST8hA/maxresdefault.jpg',
                                    name: "Bob",
                                    description: "Handsome Pug!",

                                    age: 2,
                                    sex: "male")

      @gladys = @shelter2.pets.create!(image: 'https://static.ddmcdn.com/en-us/apl/breedselector/images/breed-selector/dogs/breeds/dachshund-standard_01_lg.jpg',
                                    name: "Gladys",
                                    description: "A total terror!",
                                    age: 4,
                                    sex: "female")

      @maceo = @shelter2.pets.create!(image: 'https://upload.wikimedia.org/wikipedia/commons/0/00/1._DSC_0346_%2810096362833%29.jpg',
                                    name: "Maceo Parker",
                                    age: 10,
                                    description: "Best damn dog around!",
                                    sex: "male")

      @charlie = @shelter1.pets.create!(image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQ9IcR0ehgkAEqxBilz3GgsoQDLynWZILEPbmHQRPUrrdU0kXKV&usqp=CAU',
                                    name: "Charles",
                                    age: 6,
                                    description: "Your new best friend",
                                    sex: "male")
    end

    it 'can show a list of all the shelters in the system' do

      visit "/shelters"

      within "#shelter-0" do
        expect(page).to have_content("#{@shelter1.name}")
        expect(page).to have_content("#{@shelter1.address}")
        expect(page).to have_content("#{@shelter1.city}")
        expect(page).to have_content("#{@shelter1.state}")
        expect(page).to have_content("#{@shelter1.zip}")

        expect(page).to_not have_content("#{@shelter2.name}")
      end

      within "#shelter-1" do
        expect(page).to have_content("#{@shelter2.name}")
        expect(page).to have_content("#{@shelter2.address}")
        expect(page).to have_content("#{@shelter2.city}")
        expect(page).to have_content("#{@shelter2.state}")
        expect(page).to have_content("#{@shelter2.zip}")

        expect(page).to_not have_content("#{@shelter1.name}")
      end

      within "#shelter-2" do
        expect(page).to have_content("#{@shelter3.name}")
        expect(page).to have_content("#{@shelter3.address}")
        expect(page).to have_content("#{@shelter3.city}")
        expect(page).to have_content("#{@shelter3.state}")
        expect(page).to have_content("#{@shelter3.zip}")

        expect(page).to_not have_content("#{@shelter2.name}")
      end
    end

    it 'has a link to create a new shelter' do

      visit "/shelters"

      click_link "New Shelter"
      expect(current_path).to eq("/shelters/new")
    end

    it 'has a link next to each shelter to edit that shelters info' do
      visit "/shelters"
      within "#shelter-0" do
        click_link "Edit Shelter"
      end

      expect(current_path).to eq("/shelters/#{@shelter1.id}/edit")

      fill_in :name, with: "Don't Eat Animals"
      fill_in :address, with: "12 Be A Vegan Dr."
      fill_in :city, with: "Lake Placid"
      fill_in :state, with: "New York"
      fill_in :zip, with: "03232"

      click_button "Update Shelter"

      @shelter1.reload

      expect(current_path).to eq("/shelters/#{@shelter1.id}")

      expect(@shelter1.address).to eq("12 Be A Vegan Dr.")
      expect(@shelter1.name).to eq("Don't Eat Animals")
      expect(@shelter1.city).to eq("Lake Placid")
      expect(@shelter1.state).to eq("New York")
      expect(@shelter1.zip).to eq("03232")
    end

    it 'has a link next to each shelter to delete' do
      visit "/shelters"
      within "#shelter-0" do
        expect(page).to have_content("#{@shelter1.name}")
        click_link "Delete Shelter"
      end

      expect(current_path).to eq("/shelters")

      expect(page).to_not have_content("#{@shelter1.name}")
    end

    it 'has a link to sort all shelters alphabetically' do

      visit "/shelters"

      within "#shelter-0" do
        expect(page).to have_content("#{@shelter1.name}")
      end

      within "#shelter-1" do
        expect(page).to have_content("#{@shelter2.name}")
      end

      within "#shelter-2" do
        expect(page).to have_content("#{@shelter3.name}")
      end

      click_link "Sort Shelters Alphabetically"

      within "#shelter-0" do
        expect(page).to have_content("#{@shelter3.name}")
      end

      within "#shelter-1" do
        expect(page).to have_content("#{@shelter2.name}")
      end

      within "#shelter-2" do
        expect(page).to have_content("#{@shelter1.name}")
      end
    end

    it 'has a link to sort all shelters by number of pets' do

      visit "/shelters"

      within "#shelter-0" do
        expect(page).to have_content("#{@shelter1.name}")
      end

      within "#shelter-1" do
        expect(page).to have_content("#{@shelter2.name}")
      end

      within "#shelter-2" do
        expect(page).to have_content("#{@shelter3.name}")
      end

      click_link "Sort Shelters by Number Pets"

      within "#shelter-0" do
        expect(page).to have_content("#{@shelter3.name}")
      end

      within "#shelter-1" do
        expect(page).to have_content("#{@shelter2.name}")
      end

      within "#shelter-2" do
        expect(page).to have_content("#{@shelter1.name}")
      end
    end
  end
end
