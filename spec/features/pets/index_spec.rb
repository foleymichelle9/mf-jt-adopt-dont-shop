require 'rails_helper'

RSpec.describe 'As a visitor' do
  describe 'pets index page' do
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

    it 'shows a list of each pet in the system along with their information' do

      visit "/pets"

      within "#pet-0" do
        expect(page).to have_css("img[src*= '#{@lucille.image}']")
        expect(page).to have_content(@lucille.name)
        expect(page).to have_content(@lucille.sex)
        expect(page).to have_content(@lucille.age)

        expect(page).to_not have_content(@george.name)
      end

      within "#pet-1" do
        expect(page).to have_css("img[src*= '#{@george.image}']")
        expect(page).to have_content(@george.name)
        expect(page).to have_content(@george.sex)
        expect(page).to have_content(@george.age)

        expect(page).to_not have_content(@lucille.name)
      end
    end

    it 'has a link next to each pet where I can edit the pet' do

      visit "/pets"

      within "#pet-0" do
        expect(page).to have_css("img[src*= '#{@lucille.image}']")
        click_link "Edit Pet"
      end

      expect(current_path).to eq("/pets/#{@lucille.id}/edit")

      fill_in :image, with: "https://www.petmd.com/sites/default/files/Pit-Bull-Dog-Facts-1168732600_0.jpg"

      click_button "Update Pet"

      expect(current_path).to eq("/pets/#{@lucille.id}")
      expect(page).to have_css("img[src*= 'https://www.petmd.com/sites/default/files/Pit-Bull-Dog-Facts-1168732600_0.jpg']")

    end

    it 'has a link next to each pet to delete that pet' do

      visit "/pets"

      within "#pet-0" do
       expect(page).to have_css("img[src*= '#{@lucille.image}']")
        click_link "Delete Pet"
      end

      expect(current_path).to eq("/pets")
      expect(page).to_not have_css("img[src*= '#{@lucille.image}']")
     end

     it 'has a link to show all adoptable pets before the pets with pending status' do

      visit "/pets"

      within "#pet-0" do
       expect(page).to have_css("img[src*= '#{@lucille.image}']")
      end

      within "#pet-1" do
       expect(page).to have_css("img[src*= '#{@george.image}']")
      end

      within "#pet-2" do
       expect(page).to have_css("img[src*= '#{@bob.image}']")
      end

      within "#pet-3" do
       expect(page).to have_css("img[src*= '#{@gladys.image}']")
      end

      within "#pet-4" do
       expect(page).to have_css("img[src*= '#{@maceo.image}']")
      end

      within "#pet-5" do
       expect(page).to have_css("img[src*= '#{@charlie.image}']")
      end

      click_link "Adoptable Pets First"

      within "#pet-0" do
       expect(page).to have_css("img[src*= '#{@charlie.image}']")
      end

      within "#pet-1" do
       expect(page).to have_css("img[src*= '#{@maceo.image}']")
      end

      within "#pet-2" do
       expect(page).to have_css("img[src*= '#{@gladys.image}']")
      end

      within "#pet-3" do
       expect(page).to have_css("img[src*= '#{@bob.image}']")
      end

      within "#pet-4" do
       expect(page).to have_css("img[src*= '#{@george.image}']")
      end

      within "#pet-5" do
       expect(page).to have_css("img[src*= '#{@lucille.image}']")
      end
     end

     it 'has a link to show only adoptable pet' do

       visit "/pets"

       within "#pet-0" do
        expect(page).to have_css("img[src*= '#{@lucille.image}']")
       end

       within "#pet-1" do
        expect(page).to have_css("img[src*= '#{@george.image}']")
       end

       within "#pet-2" do
        expect(page).to have_css("img[src*= '#{@bob.image}']")
       end

       within "#pet-3" do
        expect(page).to have_css("img[src*= '#{@gladys.image}']")
       end

       within "#pet-4" do
        expect(page).to have_css("img[src*= '#{@maceo.image}']")
       end

       within "#pet-5" do
        expect(page).to have_css("img[src*= '#{@charlie.image}']")
       end

       click_link "Only Adoptable Pets"

       expect(page).to have_content(@gladys.name)
       expect(page).to_not have_content(@lucille.name)
       expect(page).to_not have_content(@george.name)
     end

     it 'has a link to show only pet who have adoption status pending' do

       visit "/pets"

       within "#pet-0" do
        expect(page).to have_css("img[src*= '#{@lucille.image}']")
       end

       within "#pet-1" do
        expect(page).to have_css("img[src*= '#{@george.image}']")
       end

       within "#pet-2" do
        expect(page).to have_css("img[src*= '#{@bob.image}']")
       end

       within "#pet-3" do
        expect(page).to have_css("img[src*= '#{@gladys.image}']")
       end

       within "#pet-4" do
        expect(page).to have_css("img[src*= '#{@maceo.image}']")
       end

       within "#pet-5" do
        expect(page).to have_css("img[src*= '#{@charlie.image}']")
       end

       click_link "Only Pets with an Adoption Pending Status"

       expect(page).to have_content(@lucille.name)
       expect(page).to have_content(@george.name)
       expect(page).to_not have_content(@gladys.name)
       expect(page).to_not have_content(@maceo.name)
     end
  end
end
