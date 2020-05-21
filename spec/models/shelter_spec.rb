require 'rails_helper'

RSpec.describe Shelter, type: :model do
  describe 'validations' do
    it {should validate_presence_of :name}
    it {should validate_presence_of :address}
    it {should validate_presence_of :city}
    it {should validate_presence_of :state}
    it {should validate_presence_of :zip}
  end

  describe 'relationships' do
    it {should have_many :pets}
    it {should have_many :reviews}
  end

  describe 'methods' do
    it 'num_pets' do
      shelter1 = Shelter.create(name: "Pet House",
                                 address: "12 Main St.",
                                 city: "Denver",
                                 state: "Colorado",
                                 zip: "80001")

      shelter2 = Shelter.create(name: "Love Pets",
                                 address: "1111 Dog St.",
                                 city: "Los Angeles",
                                 state: "California",
                                 zip: "90210")

      lucille = shelter1.pets.create!(image: 'https://justsomething.co/wp-content/uploads/2014/08/pitbull-photos-13.jpg',
                                    name: "Lucille",
                                    age: 3,
                                    sex: "female")

      george = shelter1.pets.create!(image: 'https://i1.wp.com/puppytoob.com/wp-content/uploads/2017/05/Golden-retriever.jpg?resize=752%2C443',
                                    name: "George",
                                    age: 4,
                                    sex: "Male")

      roxy = shelter2.pets.create!(image: 'https://www.google.com/url?sa=i&url=https%3A%2F%2Fmetro.co.uk%2F2018%2F03%2F09%2Fpit-bulls-banned-uk-7374795%2F&psig=AOvVaw1rkxBBAl4-VTFxhvtSv3mg&ust=1588797005290000&source=images&cd=vfe&ved=0CAIQjRxqFwoTCOj-_5rInekCFQAAAAAdAAAAABAO',
                                    name: "Roxy",
                                    age: 2,
                                    sex: "female")

      expect(shelter1.num_pets).to eq(2)
      expect(shelter2.num_pets).to eq(1)

    end

    it 'num_pets' do
      shelter1 = Shelter.create(name: "Pet House",
                                 address: "12 Main St.",
                                 city: "Denver",
                                 state: "Colorado",
                                 zip: "80001")

      review1 = shelter1.reviews.create(title: "Love this place!", rating: 3, content: "This shelter has the nicest employees and the most well-behaved dogs!")
      review2 = shelter1.reviews.create(title: "Not a fan of this place.", rating: 5, content: "The dog I adopted from this shelter bit me!", image: "https://images-prod.healthline.com/hlcmsresource/images/imce/animal-bites-finger_thumb.jpg")
      review3 = shelter1.reviews.create(title: "Favorite shelter by far!", rating: 1, content: "These people love animals!")

      expect(shelter1.avg_review).to eq(3)
    end

    it 'num_apps' do
      shelter1 = Shelter.create(name: "Pet House",
                                 address: "12 Main St.",
                                 city: "Denver",
                                 state: "Colorado",
                                 zip: "80001")

      shelter2 = Shelter.create(name: "Love Pets",
                                address: "1111 Dog St.",
                                city: "Los Angeles",
                                state: "California",
                                zip: "90210")

      lucille = shelter1.pets.create!(image: 'https://justsomething.co/wp-content/uploads/2014/08/pitbull-photos-13.jpg',
                                 name: "Lucille",
                                 age: 9,
                                 sex: "female",
                                 status: true,
                                 description: "Lovable Pitbull")

      george = shelter2.pets.create!(image: 'https://i1.wp.com/puppytoob.com/wp-content/uploads/2017/05/Golden-retriever.jpg?resize=752%2C443',
                                    name: "George",
                                    age: 4,
                                    status: true,
                                    sex: "male")

      app1 = Application.create!(name: "Josh T",
                                address: "123 Main St.",
                                city: "Denver",
                                state: "Colorado",
                                zip: "80209",
                                phone: "720-319-2655",
                                description: "I really love animals")

      app2 = Application.create!(name: "Michelle F",
                                address: "123 Fake St.",
                                city: "Madison",
                                state: "Wisconsin",
                                zip: "80209",
                                phone: "720-319-2655",
                                description: "I really love animals")
      app3 = Application.create!(name: "Meg F",
                                address: "123 Fake St.",
                                city: "Madison",
                                state: "Wisconsin",
                                zip: "80209",
                                phone: "720-319-2655",
                                description: "I really love animals")

      ApplicationPet.create(application_id: app1.id, pet_id: lucille.id)
      ApplicationPet.create(application_id: app2.id, pet_id: lucille.id)
      ApplicationPet.create(application_id: app3.id, pet_id: george.id)

      expect(shelter1.num_apps).to eq(2)
    end
  end
end
