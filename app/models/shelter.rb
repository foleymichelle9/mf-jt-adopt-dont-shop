class Shelter < ApplicationRecord
  validates :name, uniqueness: true, presence: true
  validates_presence_of :address,
                        :city,
                        :state,
                        :zip

  has_many :pets, dependent: :delete_all
  has_many :reviews, dependent: :delete_all

  def num_pets
    pets.count
  end

  def self.num_pets_desc
    @shelters = Shelter.all.sort_by{|shelter| shelter.pets.count}.reverse
  end

  def avg_review
    reviews.average(:rating).to_f
  end

  def num_apps
    pets.joins(:applications).count
  end
end
