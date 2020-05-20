require 'rails_helper'

RSpec.describe 'Pet applications index page' do
  before(:each) do
    @shelter1 = Shelter.create(name: "Pet House",
                              address: "12 Main St.",
                              city: "Denver",
                              state: "Colorado",
                              zip: "80001")

    @lucille = @shelter1.pets.create!(image: 'https://justsomething.co/wp-content/uploads/2014/08/pitbull-photos-13.jpg',
                                    name: "Lucille",
                                    age: 3,
                                    description: "Lovable pitbull",
                                    sex: "female",
                                    status: true)

    @george = @shelter1.pets.create!(image: 'https://i1.wp.com/puppytoob.com/wp-content/uploads/2017/05/Golden-retriever.jpg?resize=752%2C443',
                                   name: "George",
                                   age: 4,
                                   sex: "Male")
  end

  it 'shows the names of all the applicants for this pet as links to application show page' do

    app1 = Application.create!(name: "Josh T",
                    address: "123 Main St.",
                    city: "Denver",
                    state: "Colorado",
                    zip: "80209",
                    phone: "720-319-2655",
                    description: "I really love animals")

    app2 = Application.create!(name: "Ed M",
                    address: "222 Pleasant Dr.",
                    city: "Boulder",
                    state: "Colorado",
                    zip: "80266",
                    phone: "720-654-1234",
                    description: "Animals love me")

    app3 = Application.create!(name: "Jon M",
                    address: "345 Green St.",
                    city: "Denver",
                    state: "Colorado",
                    zip: "84444",
                    phone: "720-398-9870",
                    description: "The more pets the better")

    app4 = Application.create!(name: "Larry J",
                    address: "777 Happy Pl.",
                    city: "Aspen",
                    state: "Colorado",
                    zip: "80909",
                    phone: "720-398-5554",
                    description: "Dogs rock!")

    ApplicationPet.create(application_id: app1.id, pet_id: @lucille.id)
    ApplicationPet.create(application_id: app2.id, pet_id: @lucille.id)
    ApplicationPet.create(application_id: app3.id, pet_id: @lucille.id)
    ApplicationPet.create(application_id: app2.id, pet_id: @george.id)
    ApplicationPet.create(application_id: app3.id, pet_id: @george.id)
    ApplicationPet.create(application_id: app4.id, pet_id: @george.id)

    visit "/pets/#{@lucille.id}/applications"

    expect(page).to have_link(app1.name)
    expect(page).to have_link(app2.name)
    expect(page).to have_link(app3.name)
    expect(page).to_not have_link(app4.name)
  end

  it 'shows a message saying there are no applications for this pet when there are no current applications' do

    visit "/pets/#{@lucille.id}/applications"

    expect(page).to have_content("There aren't any current applications for #{@lucille.name}.")
  end
end
