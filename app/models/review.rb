class Review < ApplicationRecord

  validates_presence_of :title,
                        :rating,
                        :content

  validates :rating, :inclusion => { :in => 1..5 }

  belongs_to :shelter
end
