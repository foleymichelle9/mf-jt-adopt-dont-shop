require 'rails_helper'

RSpec.describe 'As a visitor' do
  describe 'shelter pets index page' do
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

      @lucille = @shelter1.pets.create!(image: 'https://justsomething.co/wp-content/uploads/2014/08/pitbull-photos-13.jpg',
                                    name: "Lucille",
                                    age: 3,
                                    sex: "female")

      @george = @shelter1.pets.create!(image: 'https://i1.wp.com/puppytoob.com/wp-content/uploads/2017/05/Golden-retriever.jpg?resize=752%2C443',
                                    name: "George",
                                    age: 4,
                                    status: false,
                                    sex: "Male")

      @roxy = @shelter2.pets.create!(image: 'https://www.google.com/url?sa=i&url=https%3A%2F%2Fmetro.co.uk%2F2018%2F03%2F09%2Fpit-bulls-banned-uk-7374795%2F&psig=AOvVaw1rkxBBAl4-VTFxhvtSv3mg&ust=1588797005290000&source=images&cd=vfe&ved=0CAIQjRxqFwoTCOj-_5rInekCFQAAAAAdAAAAABAO',
                                    name: "Roxy",
                                    age: 2,
                                    sex: "female")

      @bob = @shelter2.pets.create!(image: 'https://i.ytimg.com/vi/8FCSw-ST8hA/maxresdefault.jpg',
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

      @charlie = @shelter2.pets.create!(image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQ9IcR0ehgkAEqxBilz3GgsoQDLynWZILEPbmHQRPUrrdU0kXKV&usqp=CAU',
                                    name: "Charles",
                                    age: 6,
                                    description: "Your new best friend",
                                    sex: "male")

    end

    it 'shows all the pets that can be adopted from the shelter with that id' do

      visit "/shelters/#{@shelter1.id}/pets"

      expect(page).to_not have_content(@shelter2.name)

      within "#pet-#{@lucille.id}" do
        expect(page).to have_css("img[src*= '#{@lucille.image}']")
        expect(page).to have_content(@lucille.name)
        expect(page).to have_content(@lucille.age)
        expect(page).to have_content(@lucille.sex)

        expect(page).to_not have_content(@george.name)
        expect(page).to_not have_content(@roxy.name)
      end

      within "#pet-#{@george.id}" do
        expect(page).to have_css("img[src*= '#{@george.image}']")
        expect(page).to have_content(@george.name)
        expect(page).to have_content(@george.age)
        expect(page).to have_content(@george.sex)

        expect(page).to_not have_content(@lucille.name)
        expect(page).to_not have_content(@roxy.name)
      end
    end

    it 'has a link to create a new pet for that shelter' do

      visit "/shelters/#{@shelter1.id}/pets"

      click_link "Create Pet"

      expect(current_path).to eq("/shelters/#{@shelter1.id}/pets/new")
    end

    it 'has a link next to each pet where I can edit the pet' do

      visit "shelters/#{@shelter1.id}/pets"

      within "#pet-#{@lucille.id}" do
        expect(page).to have_css("img[src*= '#{@lucille.image}']")
        click_link "Edit Pet"
      end

      expect(current_path).to eq("/pets/#{@lucille.id}/edit")

      fill_in :image, with: "https://www.petmd.com/sites/default/files/Pit-Bull-Dog-Facts-1168732600_0.jpg"

      click_button "Update Pet"

      expect(current_path).to eq("/pets/#{@lucille.id}")
      expect(page).to have_css("img[src*= 'https://www.petmd.com/sites/default/files/Pit-Bull-Dog-Facts-1168732600_0.jpg']")

      visit "/shelters/#{@shelter1.id}/pets"
      within "#pet-#{@lucille.id}" do
        expect(page).to have_css("img[src*= 'https://www.petmd.com/sites/default/files/Pit-Bull-Dog-Facts-1168732600_0.jpg']")
      end
    end

    it 'has a link next to each pet to delete that pet' do

      visit "/shelters/#{@shelter1.id}/pets"

      within "#pet-#{@lucille.id}" do
       expect(page).to have_css("img[src*= '#{@lucille.image}']")
        click_link "Delete Pet"
      end

      expect(current_path).to eq("/shelters/#{@shelter1.id}/pets")
      expect(page).to_not have_css("img[src*= '#{@lucille.image}']")
    end

    it 'has a count of the number of pets at that shelter' do

      visit "/shelters/#{@shelter1.id}/pets"

      expect(page).to have_content("Number of pets currently: 2")
    end

    it 'has a link to show only Adoptable Pets' do

      visit "/shelters/#{@shelter1.id}/pets"

      within "#pet-#{@lucille.id}" do
       expect(page).to have_css("img[src*= '#{@lucille.image}']")
      end

      within "#pet-#{@george.id}" do
       expect(page).to have_css("img[src*= '#{@george.image}']")
      end

      click_link "Only Adoptable Pets"

      expect(page).to have_content(@lucille.name)
      expect(page).to_not have_content(@george.name)
    end

    it 'has a link to show only Pets with Adoption Pending status' do

      visit "/shelters/#{@shelter1.id}/pets"

      within "#pet-#{@lucille.id}" do
       expect(page).to have_css("img[src*= '#{@lucille.image}']")
      end

      within "#pet-#{@george.id}" do
       expect(page).to have_css("img[src*= '#{@george.image}']")
      end

      click_link "Only Pets with an Adoption Pending Status"

      expect(page).to have_content(@george.name)
      expect(page).to_not have_content(@lucille.name)
    end
  end
end
