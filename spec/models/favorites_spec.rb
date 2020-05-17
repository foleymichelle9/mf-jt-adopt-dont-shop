require 'rails_helper'

RSpec.describe Favorites, type: :model do
  describe '#total_count' do
    it 'can calculate the total number of pets it holds' do

      favorites = Favorites.new({
        '1' => 1,  # two copies of song 1
        '2' => 1   # three copies of song 2
      })

      expect(favorites.total_count).to eq(2)
    end
  end

  describe "#add_pet" do
    it "adds a pet to its contents" do
      favorites = Favorites.new({
        '1' => 1,
        '2' => 1
      })

      favorites.add_pet('3')
      favorites.add_pet('4')

      expect(favorites.contents).to eq({'1' => 1, '2' => 1, '3' => 1, '4' => 1})
    end

    it 'adds a pet that hasnt been added yet' do
      favorites = Favorites.new({
        '1' => 1,
        '2' => 1
      })

      favorites.add_pet('8')
      expect(favorites.contents).to eq({'1' => 1, '2' => 1, '8' => 1})
    end
  end

  describe "#count_of" do
    it 'returns the count of all the pets in the favorites' do
      favorites = Favorites.new({})

      expect(favorites.count_of('5')).to eq(0)
    end
  end

  describe "#favorite_pets" do
    it 'returns an array of pet objects from favorites' do

      shelter1 = Shelter.create(name: "Pet House",
                                   address: "12 Main St.",
                                   city: "Denver",
                                   state: "Colorado",
                                   zip: "80001")

      lucille = shelter1.pets.create!(image: 'https://justsomething.co/wp-content/uploads/2014/08/pitbull-photos-13.jpg',
                                    name: "Lucille",
                                    age: 3,
                                    status: false,
                                    sex: "female")

      george = shelter1.pets.create!(image: 'https://i1.wp.com/puppytoob.com/wp-content/uploads/2017/05/Golden-retriever.jpg?resize=752%2C443',
                                    name: "George",
                                    age: 4,
                                    status: false,
                                    sex: "Male")

      bob = shelter1.pets.create!(image: 'https://i.ytimg.com/vi/8FCSw-ST8hA/maxresdefault.jpg',
                                   name: "Bob",
                                   description: "Handsome Pug!",
                                   age: 2,
                                   sex: "male")

      favorites = Favorites.new({})
      favorites.add_pet(lucille.id)
      favorites.add_pet(george.id)
      favorites.add_pet(bob.id)

      expect(favorites.favorite_pets).to eq([lucille, george, bob])
    end
  end

  describe '#selection_form_ready' do
    it 'returns an array of arrays containing pet names with number starting at 1' do

      shelter1 = Shelter.create(name: "Pet House",
                                   address: "12 Main St.",
                                   city: "Denver",
                                   state: "Colorado",
                                   zip: "80001")

      lucille = shelter1.pets.create!(image: 'https://justsomething.co/wp-content/uploads/2014/08/pitbull-photos-13.jpg',
                                    name: "Lucille",
                                    age: 3,
                                    status: false,
                                    sex: "female")

      george = shelter1.pets.create!(image: 'https://i1.wp.com/puppytoob.com/wp-content/uploads/2017/05/Golden-retriever.jpg?resize=752%2C443',
                                    name: "George",
                                    age: 4,
                                    status: false,
                                    sex: "Male")

      bob = shelter1.pets.create!(image: 'https://i.ytimg.com/vi/8FCSw-ST8hA/maxresdefault.jpg',
                                   name: "Bob",
                                   description: "Handsome Pug!",
                                   age: 2,
                                   sex: "male")

      favorites = Favorites.new({})
      favorites.add_pet(lucille.id)
      favorites.add_pet(george.id)
      favorites.add_pet(bob.id)

      expect(favorites.selection_form_ready).to eq([[lucille.name, 1], [george.name, 2],[bob.name, 3]])
    end
  end
end
