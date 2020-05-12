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
  end

end
