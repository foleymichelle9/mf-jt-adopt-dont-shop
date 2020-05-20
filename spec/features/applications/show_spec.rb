require 'rails_helper'

RSpec.describe 'Application show page' do
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
                                    status: true,
                                    sex: "female")

    @george = @shelter2.pets.create!(image: 'https://i1.wp.com/puppytoob.com/wp-content/uploads/2017/05/Golden-retriever.jpg?resize=752%2C443',
                                    name: "George",
                                    age: 4,
                                    status: true,
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
    end

    it 'shows all the information attached to this application' do

    visit "/applications/new"

    check(@lucille.id)
    check(@bob.id)

    fill_in :name, with: "Josh"
    fill_in :address, with: "123 Main St"
    fill_in :city, with: "Denver"
    fill_in :state, with: "Colorado"
    fill_in :zip, with: "80209"
    fill_in :phone, with: "720-319-2655"
    fill_in :description, with: "I'm a good person and I love dogs."

    click_button "Submit Application"

    application = Application.last

    visit "/applications/#{application.id}"
    expect(page).to have_content("Josh")
    expect(page).to have_content("123 Main St")
    expect(page).to have_content("Denver")
    expect(page).to have_content("Colorado")
    expect(page).to have_content("80209")
    expect(page).to have_content("720-319-2655")
    expect(page).to have_content("I'm a good person and I love dogs.")
    expect(page).to have_link("Lucille")
    expect(page).to have_link("Bob")
  end

  it 'has a link to approve the application for each pet' do

    app1 = Application.create!(name: "Josh T",
                               address: "123 Main St.",
                               city: "Denver",
                               state: "Colorado",
                               zip: "80209",
                               phone: "720-319-2655",
                               description: "I really love animals")

     ApplicationPet.create(application_id: app1.id, pet_id: @lucille.id)
     ApplicationPet.create(application_id: app1.id, pet_id: @george.id)
     ApplicationPet.create(application_id: app1.id, pet_id: @gladys.id)
     ApplicationPet.create(application_id: app1.id, pet_id: @charlie.id)
     ApplicationPet.create(application_id: app1.id, pet_id: @maceo.id)
     ApplicationPet.create(application_id: app1.id, pet_id: @bob.id)

     visit "/pets/#{@lucille.id}"
     expect(page).to have_content("Adoptable")

     visit "/applications/#{app1.id}"

     within ".pet-#{@lucille.id}" do
       click_link "Approve application"
     end

     visit "/pets/#{@lucille.id}"
     expect(page).to have_content("Pending")
  end

  it 'can approve the application for any number of pets' do
    app1 = Application.create!(name: "Josh T",
                               address: "123 Main St.",
                               city: "Denver",
                               state: "Colorado",
                               zip: "80209",
                               phone: "720-319-2655",
                               description: "I really love animals")

     ApplicationPet.create(application_id: app1.id, pet_id: @lucille.id)
     ApplicationPet.create(application_id: app1.id, pet_id: @george.id)
     ApplicationPet.create(application_id: app1.id, pet_id: @gladys.id)
     ApplicationPet.create(application_id: app1.id, pet_id: @charlie.id)
     ApplicationPet.create(application_id: app1.id, pet_id: @maceo.id)

     visit "/applications/#{app1.id}"

     within ".pet-#{@lucille.id}" do
       click_link "Approve application"
     end

     visit "/applications/#{app1.id}"

     within ".pet-#{@george.id}" do
       click_link "Approve application"
     end

     visit "/applications/#{app1.id}"

     within ".pet-#{@gladys.id}" do
       click_link "Approve application"
     end

     visit "/applications/#{app1.id}"

     within ".pet-#{@charlie.id}" do
       click_link "Approve application"
     end

  end
end
