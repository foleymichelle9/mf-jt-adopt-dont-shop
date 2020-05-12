class Shelter < ApplicationRecord
  validates :name, uniqueness: true, presence: true
  validates_presence_of :address,
                        :city,
                        :state,
                        :zip

  has_many :pets, dependent: :delete_all

  def num_pets
    pets.count
  end

  def self.num_pets_desc
    @shelters = Shelter.all.sort_by{|shelter| shelter.pets.count}.reverse
  end

end
