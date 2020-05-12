class Review < ApplicationRecord

  validates_presence_of :title,
                        :rating,
                        :content
                        
  belongs_to :shelter
end
