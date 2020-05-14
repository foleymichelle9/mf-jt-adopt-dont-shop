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
end
