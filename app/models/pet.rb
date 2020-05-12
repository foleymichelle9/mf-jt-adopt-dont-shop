class Pet < ApplicationRecord

  validates_presence_of :image,
                        :name,
                        :age,
                        :sex

  belongs_to :shelter

  def adoptable_status
    if status
      "Adoptable!"
    else
      "Pending"
    end
  end

  def self.sort_by_status
    Pet.order(status: :desc)
  end
end
